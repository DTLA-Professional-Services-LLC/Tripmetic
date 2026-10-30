import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sealed_currencies/sealed_currencies.dart';

import '../../../core/data/sync/remote_rates_data_source.dart';
import '../domain/bundled_usd_rates.dart';
import '../domain/exchange_rate_snapshot.dart';

const _kBoxName = 'tripmetic_cache';
const _kRatesKey = 'exchange_rates_v2';
const _kUpdatedKey = 'exchange_rates_updated_ms';
const _kSelectionKey = 'currency_selection_v1';
const _kUsdAmountKey = 'currency_usd_amount_v1';

/// Refresh Hive-backed rates when older than this (Firebase/Firestore pipeline).
const Duration kExchangeRatesCacheTtl = Duration(hours: 12);

/// Default slot order: base is first.
const List<String> kDefaultCurrencySelection = [
  'USD',
  'PHP',
  'VND',
  'EUR',
  'JPY',
  'MXN',
];

/// Offline-first rates: Hive holds snapshots; [RemoteRatesDataSource] streams updates.
///
/// - TTL: when Hive [exchange_rates_updated_ms] is older than [kExchangeRatesCacheTtl],
///   a server read refreshes rates on [open] / [ensureFreshRatesIfNeeded].
/// - Firestore cache snapshots (`isOffline`) do not overwrite Hive (prevents stale overlay).
class CurrencyRepository {
  CurrencyRepository(this._remote);

  final RemoteRatesDataSource _remote;

  Box<dynamic>? _box;
  StreamSubscription<ExchangeRateSnapshot>? _remoteSub;
  final _controller = StreamController<ExchangeRateSnapshot>.broadcast();

  Stream<ExchangeRateSnapshot> watchRates() async* {
    yield _readFromBox() ?? ExchangeRateSnapshot.defaults();
    yield* _controller.stream;
  }

  bool _isHiveOlderThanTtl() {
    final box = _box;
    if (box == null) return false;
    final updatedMs = box.get(_kUpdatedKey);
    if (updatedMs is! int) return true;
    final updated = DateTime.fromMillisecondsSinceEpoch(updatedMs, isUtc: true);
    final age = DateTime.now().toUtc().difference(updated);
    return age > kExchangeRatesCacheTtl;
  }

  /// Pull-to-refresh: always hits the server (TTL bypass).
  /// Returns the persisted snapshot when the fetch succeeds.
  Future<ExchangeRateSnapshot?> refreshFromNetwork() async {
    if (_box == null) return null;
    try {
      final snap = await _remote.fetchLatest(forceServer: true);
      if (snap != null) {
        final fresh = snap.withSyncedNow();
        await _persist(fresh);
        _controller.add(fresh);
        return fresh;
      }
    } catch (e, st) {
      debugPrint(
        'CurrencyRepository: failed to refresh rates from network (using cache): $e\n$st',
      );
    }
    return tryPersistedSnapshot();
  }

  /// Hive-backed snapshot, or `null` when nothing has been persisted yet.
  ExchangeRateSnapshot? tryPersistedSnapshot() => _readFromBox();

  /// Latest persisted FX snapshot, or bundled defaults when Hive is empty.
  ExchangeRateSnapshot currentSnapshot() {
    return tryPersistedSnapshot() ?? ExchangeRateSnapshot.defaults();
  }

  Future<void> _revalidate({required bool ignoreTtl}) async {
    if (_box == null) return;
    if (!ignoreTtl && !_isHiveOlderThanTtl()) return;

    try {
      final snap = await _remote.fetchLatest(forceServer: true);
      if (snap != null) {
        final fresh = ignoreTtl ? snap.withSyncedNow() : snap;
        await _persist(fresh);
        _controller.add(fresh);
      }
    } catch (e, st) {
      debugPrint(
        'CurrencyRepository: failed to refresh rates from network (using cache): $e\n$st',
      );
    }
  }

  /// Called after app bootstrap / when opening tools — skips fetch if cache is fresh.
  Future<void> ensureFreshRatesIfNeeded() => _revalidate(ignoreTtl: false);

  /// Clears persisted rate snapshot timestamps so the next fetch cannot reuse stale TTL logic,
  /// then forces a network refresh (Firestore server read).
  Future<ExchangeRateSnapshot?> clearRateCacheAndRefresh() async {
    final box = _box;
    if (box == null) return null;
    await box.delete(_kRatesKey);
    await box.delete(_kUpdatedKey);
    return refreshFromNetwork();
  }

  Future<void> open() async {
    _box = await Hive.openBox<dynamic>(_kBoxName);

    // Do not block app startup on FX network — refresh in the background.
    unawaited(_revalidate(ignoreTtl: false));

    await _remoteSub?.cancel();
    _remoteSub = _remote.watchRates().listen(
      (remote) async {
        if (!remote.isOffline) {
          await _persist(remote);
          _controller.add(remote);
          return;
        }

        // Ignore stale Firestore cache events when Hive already has fresher data.
        final cached = _readFromBox();
        if (cached != null &&
            !remote.updatedAt.isAfter(cached.updatedAt)) {
          return;
        }
        _controller.add(remote);
      },
      onError: (Object e, StackTrace st) {
        debugPrint('CurrencyRepository watchRates stream error: $e\n$st');
        final cached = _readFromBox();
        if (cached != null) _controller.add(cached);
      },
    );
  }

  ExchangeRateSnapshot? _readFromBox() {
    final box = _box;
    if (box == null) return null;
    final raw = box.get(_kRatesKey);
    final updatedMs = box.get(_kUpdatedKey) as int?;
    if (raw is! Map) return null;
    final stored = <String, double>{};
    for (final e in raw.entries) {
      final k = e.key.toString();
      final v = e.value;
      if (v is num) stored[k] = v.toDouble();
    }
    if (stored.isEmpty) return null;

    final merged = <String, double>{};
    for (final f in FiatCurrency.listExtended) {
      merged[f.code] = BundledUsdRates.byCode[f.code] ?? 1.0;
    }
    for (final e in stored.entries) {
      merged[e.key] = e.value;
    }
    merged['USD'] = 1.0;

    return ExchangeRateSnapshot(
      rates: merged,
      updatedAt: updatedMs != null
          ? DateTime.fromMillisecondsSinceEpoch(updatedMs, isUtc: true)
          : DateTime.now().toUtc(),
      isOffline: _isHiveOlderThanTtl(),
    );
  }

  Future<void> _persist(ExchangeRateSnapshot snapshot) async {
    final box = _box;
    if (box == null) return;

    final overlays = snapshot.serverRateOverlays;
    final stored = overlays.isNotEmpty ? overlays : snapshot.rates;
    if (stored.isEmpty) return;

    await box.put(_kRatesKey, stored);
    final updatedMs = snapshot.updatedAt.millisecondsSinceEpoch;
    if (updatedMs > 0) {
      await box.put(_kUpdatedKey, updatedMs);
    }
  }

  Future<void> saveSelection(List<String> codes) async {
    final box = _box;
    if (box == null) return;
    final normalized = _normalizeSelection(codes);
    await box.put(_kSelectionKey, normalized);
  }

  List<String>? readSelection() {
    final box = _box;
    if (box == null) return null;
    final raw = box.get(_kSelectionKey);
    if (raw is! List) return null;
    final list = raw.map((e) => e.toString()).toList();
    return _normalizeSelection(list);
  }

  List<String> _normalizeSelection(List<String> raw) {
    final out = <String>[];
    for (final r in raw) {
      final upper = r.toUpperCase();
      final f = FiatCurrency.maybeFromCode(upper);
      out.add(f?.code ?? 'USD');
    }
    while (out.length < 6) {
      out.add('USD');
    }
    if (out.length > 6) {
      return out.take(6).toList();
    }
    return out;
  }

  Future<void> saveUsdAmount(double amount) async {
    final box = _box;
    if (box == null) return;
    if (amount.isNaN || amount.isInfinite) return;
    await box.put(_kUsdAmountKey, amount);
  }

  double? readUsdAmount() {
    final box = _box;
    if (box == null) return null;
    final v = box.get(_kUsdAmountKey);
    if (v is num) return v.toDouble();
    return null;
  }

  Future<void> dispose() async {
    await _remoteSub?.cancel();
    await _controller.close();
  }
}
