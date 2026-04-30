import 'dart:async';

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

/// Default slot order: base is first.
const List<String> kDefaultCurrencySelection = [
  'USD',
  'PHP',
  'VND',
  'EUR',
  'JPY',
  'MXN',
];

/// Offline-first rates: Hive is the source of truth; [RemoteRatesDataSource]
/// can push updates (e.g. Firestore) which are persisted locally.
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

  Future<void> open() async {
    _box = await Hive.openBox<dynamic>(_kBoxName);

    await _remoteSub?.cancel();
    _remoteSub = _remote.watchRates().listen(
      (remote) async {
        await _persist(remote);
        _controller.add(remote);
      },
      onError: (Object _, StackTrace _) {
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
      isOffline: true,
    );
  }

  Future<void> _persist(ExchangeRateSnapshot snapshot) async {
    final box = _box;
    if (box == null) return;
    await box.put(_kRatesKey, snapshot.rates);
    await box.put(_kUpdatedKey, snapshot.updatedAt.millisecondsSinceEpoch);
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
