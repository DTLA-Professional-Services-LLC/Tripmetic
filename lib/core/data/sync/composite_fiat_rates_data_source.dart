import 'package:flutter/foundation.dart';

import '../../../features/currency/domain/exchange_rate_snapshot.dart';
import 'firestore_fiat_rates_data_source.dart';
import 'frankfurter_fiat_rates_data_source.dart';
import 'remote_rates_data_source.dart';

/// Tries Firestore first, then the public Frankfurter feed when Firestore fails or
/// returns no usable overlay (e.g. permission denied on the widget background path).
class CompositeFiatRatesDataSource implements RemoteRatesDataSource {
  CompositeFiatRatesDataSource({
    RemoteRatesDataSource? primary,
    RemoteRatesDataSource? fallback,
  })  : _primary = primary ?? FirestoreRemoteRatesDataSource(),
        _fallback = fallback ?? FrankfurterFiatRatesDataSource();

  final RemoteRatesDataSource _primary;
  final RemoteRatesDataSource _fallback;

  @override
  Stream<ExchangeRateSnapshot> watchRates() => _primary.watchRates();

  @override
  Future<ExchangeRateSnapshot?> fetchLatest({bool forceServer = true}) async {
    try {
      final primary = await _primary.fetchLatest(forceServer: forceServer);
      if (primary != null && primary.serverRateOverlays.length > 1) {
        return primary;
      }
      if (primary == null) {
        debugPrint('CompositeFiatRatesDataSource: primary returned null, trying fallback');
      }
    } catch (e, st) {
      debugPrint('CompositeFiatRatesDataSource: primary failed: $e\n$st');
    }

    final fallback = await _fallback.fetchLatest(forceServer: forceServer);
    if (fallback != null) {
      debugPrint(
        'CompositeFiatRatesDataSource: using Frankfurter (${fallback.serverRateOverlays.length} codes)',
      );
    }
    return fallback;
  }
}
