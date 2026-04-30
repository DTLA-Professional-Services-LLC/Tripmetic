import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sealed_currencies/sealed_currencies.dart';

import '../../../features/currency/domain/bundled_usd_rates.dart';
import '../../../features/currency/domain/exchange_rate_snapshot.dart';
import 'remote_rates_data_source.dart';

void _swallowFirestoreStreamError(Object error, StackTrace stackTrace) {}

/// Listens to [fiat_rates/latest] and maps the `rates` field into [ExchangeRateSnapshot].
///
/// Unknown codes from Firestore are merged in; known fiat codes fall back to bundled
/// values until the server supplies them.
class FirestoreRemoteRatesDataSource implements RemoteRatesDataSource {
  FirestoreRemoteRatesDataSource({FirebaseFirestore? firestore}) : _explicit = firestore;

  /// When null, [FirebaseFirestore.instance] is read on first [watchRates] emission only.
  final FirebaseFirestore? _explicit;

  FirebaseFirestore get _db => _explicit ?? FirebaseFirestore.instance;

  @override
  Stream<ExchangeRateSnapshot> watchRates() {
    return _db
        .collection('fiat_rates')
        .doc('latest')
        .snapshots()
        .map(_mapDocument)
        .where((s) => s != null)
        .cast<ExchangeRateSnapshot>()
        .handleError(_swallowFirestoreStreamError);
  }

  ExchangeRateSnapshot? _mapDocument(DocumentSnapshot<Map<String, dynamic>> snap) {
    if (!snap.exists) return null;
    final data = snap.data();
    if (data == null) return null;

    final raw = data['rates'];
    if (raw is! Map) return null;

    final merged = <String, double>{};
    for (final f in FiatCurrency.listExtended) {
      merged[f.code] = BundledUsdRates.byCode[f.code] ?? 1.0;
    }
    merged['USD'] = 1.0;

    var overlayCount = 0;
    for (final e in raw.entries) {
      final code = e.key.toString().toUpperCase();
      final v = _toDouble(e.value);
      if (v != null && v > 0) {
        merged[code] = v;
        overlayCount++;
      }
    }
    merged['USD'] = 1.0;

    if (overlayCount == 0) return null;

    return ExchangeRateSnapshot(
      rates: merged,
      updatedAt: _parseUpdatedAt(data),
      isOffline: snap.metadata.isFromCache,
    );
  }
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is Map) {
    for (final key in ['usd', 'USD', 'price', 'value', 'rate']) {
      final inner = value[key];
      if (inner != null) return _toDouble(inner);
    }
  }
  return null;
}

DateTime _parseUpdatedAt(Map<String, dynamic> data) {
  for (final key in ['updated_at', 'updatedAt', 'asOf', 'timestamp', 'last_updated']) {
    final v = data[key];
    if (v is Timestamp) return v.toDate().toUtc();
    if (v is DateTime) return v.toUtc();
    if (v is int) return DateTime.fromMillisecondsSinceEpoch(v, isUtc: true);
    if (v is String) {
      final parsed = DateTime.tryParse(v);
      if (parsed != null) return parsed.toUtc();
    }
  }
  return DateTime.now().toUtc();
}
