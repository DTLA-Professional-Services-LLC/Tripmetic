import 'package:sealed_currencies/sealed_currencies.dart';

import 'bundled_usd_rates.dart';

/// Rates are units of each currency per **1 USD** (USD is always 1).
class ExchangeRateSnapshot {
  const ExchangeRateSnapshot({
    required this.rates,
    required this.updatedAt,
    this.isOffline = true,
  });

  final Map<String, double> rates;
  final DateTime updatedAt;
  final bool isOffline;

  factory ExchangeRateSnapshot.defaults() {
    final rates = <String, double>{};
    for (final f in FiatCurrency.listExtended) {
      rates[f.code] = BundledUsdRates.byCode[f.code] ?? 1.0;
    }
    rates['USD'] = 1.0;
    return ExchangeRateSnapshot(
      rates: rates,
      updatedAt: DateTime.now().toUtc(),
      isOffline: true,
    );
  }

  double rateFor(String code) => rates[code] ?? BundledUsdRates.byCode[code] ?? 1.0;

  double convert({
    required double amountInFrom,
    required String from,
    required String to,
  }) {
    final usd = amountInFrom / rateFor(from);
    return usd * rateFor(to);
  }
}
