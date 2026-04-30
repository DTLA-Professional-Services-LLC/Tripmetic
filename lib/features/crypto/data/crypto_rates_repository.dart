import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import 'crypto_catalog.dart';
import 'remote_crypto_rates_data_source.dart';
import '../domain/crypto_rates_snapshot.dart';

const _kBoxName = 'tripmetic_cache';
const _kCryptoRatesKey = 'crypto_rates_v1';
const _kCryptoUpdatedKey = 'crypto_rates_updated_ms';

/// Offline-first crypto rates: Hive holds last good snapshot; Firestore pushes updates.
class CryptoRatesRepository {
  CryptoRatesRepository(this._remote);

  final RemoteCryptoRatesDataSource _remote;

  Box<dynamic>? _box;
  StreamSubscription<CryptoRatesSnapshot>? _remoteSub;
  final _controller = StreamController<CryptoRatesSnapshot>.broadcast();

  CryptoRatesSnapshot _fallback() {
    return CryptoRatesSnapshot(
      rates: cryptoRatesMap(),
      updatedAt: DateTime.now().toUtc(),
      isOffline: true,
    );
  }

  Stream<CryptoRatesSnapshot> watchRates() async* {
    yield _readFromBox() ?? _fallback();
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

  CryptoRatesSnapshot? _readFromBox() {
    final box = _box;
    if (box == null) return null;
    final raw = box.get(_kCryptoRatesKey);
    final updatedMs = box.get(_kCryptoUpdatedKey) as int?;
    if (raw is! Map) return null;
    final stored = <String, double>{};
    for (final e in raw.entries) {
      final k = e.key.toString().toUpperCase();
      final v = e.value;
      if (v is num) stored[k] = v.toDouble();
    }
    if (stored.isEmpty) return null;

    final merged = Map<String, double>.from(cryptoRatesMap());
    for (final e in stored.entries) {
      merged[e.key] = e.value;
    }
    merged['USD'] = 1.0;

    return CryptoRatesSnapshot(
      rates: merged,
      updatedAt: updatedMs != null
          ? DateTime.fromMillisecondsSinceEpoch(updatedMs, isUtc: true)
          : DateTime.now().toUtc(),
      isOffline: true,
    );
  }

  Future<void> _persist(CryptoRatesSnapshot snapshot) async {
    final box = _box;
    if (box == null) return;
    await box.put(_kCryptoRatesKey, snapshot.rates);
    await box.put(_kCryptoUpdatedKey, snapshot.updatedAt.millisecondsSinceEpoch);
  }

  Future<void> dispose() async {
    await _remoteSub?.cancel();
    await _controller.close();
  }
}
