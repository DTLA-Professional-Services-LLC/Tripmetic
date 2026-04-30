import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:sealed_currencies/sealed_currencies.dart';

import '../domain/exchange_rate_snapshot.dart';

double? parseAmountInput(String raw) {
  final s = raw.trim().replaceAll(',', '');
  if (s.isEmpty) return null;
  return double.tryParse(s);
}

int decimalDigitsFor(FiatCurrency c) {
  final u = c.subunitToUnit;
  if (u <= 1) return 0;
  return (math.log(u) / math.ln10).round();
}

/// Formats amounts for display using ISO subunit rules from [FiatCurrency].
String formatForCurrency(double value, FiatCurrency currency) {
  final d = decimalDigitsFor(currency);
  if (d == 0) {
    return NumberFormat('#,##0', 'en_US').format(value.round());
  }
  return NumberFormat('#,##0.${'0' * d}', 'en_US').format(value);
}

double amountFromUsd(ExchangeRateSnapshot snap, String code, double usd) {
  return usd * snap.rateFor(code);
}

double usdFromAmount(ExchangeRateSnapshot snap, String code, double amount) {
  return amount / snap.rateFor(code);
}

FiatCurrency fiatCurrencyOrUsd(String code) {
  return FiatCurrency.maybeFromCode(code) ?? FiatCurrency.fromCode('USD');
}
