import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/crypto/data/crypto_catalog.dart';
import '../../../features/crypto/data/remote_crypto_rates_data_source.dart';
import '../../../features/crypto/domain/crypto_rates_snapshot.dart';

void _swallowFirestoreStreamError(Object error, StackTrace stackTrace) {}

/// Listens to [crypto_rates/latest] and maps the `rates` map into [CryptoRatesSnapshot].
///
/// Merges on top of catalog defaults so the picker and formatting stay consistent.
class FirestoreRemoteCryptoRatesDataSource implements RemoteCryptoRatesDataSource {
  FirestoreRemoteCryptoRatesDataSource({FirebaseFirestore? firestore}) : _explicit = firestore;

  final FirebaseFirestore? _explicit;

  FirebaseFirestore get _db => _explicit ?? FirebaseFirestore.instance;

  @override
  Stream<CryptoRatesSnapshot> watchRates() {
    return _db
        .collection('crypto_rates')
        .doc('latest')
        .snapshots()
        .map(_mapDocument)
        .where((s) => s != null)
        .cast<CryptoRatesSnapshot>()
        .handleError(_swallowFirestoreStreamError);
  }

  CryptoRatesSnapshot? _mapDocument(DocumentSnapshot<Map<String, dynamic>> snap) {
    if (!snap.exists) return null;
    final data = snap.data();
    if (data == null) return null;

    final raw = data['rates'] ?? data['prices'] ?? data['data'];
    if (raw is! Map) return null;

    final merged = Map<String, double>.from(cryptoRatesMap());
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

    return CryptoRatesSnapshot(
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
    for (final key in ['usd', 'USD', 'price', 'value', 'rate', 'usdPrice']) {
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
