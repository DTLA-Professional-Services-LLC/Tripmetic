import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sealed_currencies/sealed_currencies.dart';

import '../../../features/currency/domain/bundled_usd_rates.dart';
import '../../../features/currency/domain/exchange_rate_snapshot.dart';
import 'remote_rates_data_source.dart';

/// Public ECB-based FX feed (no API key). Used when Firestore is unavailable.
///
/// Rates are units of each currency per **1 USD** — same convention as [ExchangeRateSnapshot].
class FrankfurterFiatRatesDataSource implements RemoteRatesDataSource {
  static const _latestUsdUrl = 'https://api.frankfurter.app/latest?from=USD';

  @override
  Stream<ExchangeRateSnapshot> watchRates() async* {
    final snap = await fetchLatest();
    if (snap != null) yield snap;
  }

  @override
  Future<ExchangeRateSnapshot?> fetchLatest({bool forceServer = true}) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(_latestUsdUrl));
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        debugPrint(
          'FrankfurterFiatRatesDataSource: HTTP ${response.statusCode}',
        );
        return null;
      }
      final body = await response.transform(utf8.decoder).join();
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) return null;
      return _mapResponse(json);
    } catch (e, st) {
      debugPrint('FrankfurterFiatRatesDataSource.fetchLatest: $e\n$st');
      return null;
    } finally {
      client.close();
    }
  }

  ExchangeRateSnapshot? _mapResponse(Map<String, dynamic> data) {
    final raw = data['rates'];
    if (raw is! Map) return null;

    final merged = <String, double>{};
    for (final f in FiatCurrency.listExtended) {
      merged[f.code] = BundledUsdRates.byCode[f.code] ?? 1.0;
    }
    merged['USD'] = 1.0;

    final serverOverlays = <String, double>{'USD': 1.0};
    for (final e in raw.entries) {
      final code = e.key.toString().toUpperCase();
      final v = _toDouble(e.value);
      if (v != null && v > 0) {
        merged[code] = v;
        serverOverlays[code] = v;
      }
    }
    merged['USD'] = 1.0;

    if (serverOverlays.length <= 1) return null;

    final dateRaw = data['date'];
    DateTime updatedAt = DateTime.now().toUtc();
    if (dateRaw is String) {
      final parsed = DateTime.tryParse(dateRaw);
      if (parsed != null) {
        updatedAt = DateTime.utc(parsed.year, parsed.month, parsed.day, 12);
      }
    }

    return ExchangeRateSnapshot(
      rates: merged,
      updatedAt: updatedAt,
      isOffline: false,
      serverRateOverlays: serverOverlays,
    );
  }
}

double? _toDouble(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value.trim());
  return null;
}
