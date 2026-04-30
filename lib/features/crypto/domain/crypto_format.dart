import 'package:intl/intl.dart';

final _usdAmount = NumberFormat('#,##0.00', 'en_US');

/// Groups integer digits with commas (handles an optional leading '-').
String _commaGroupIntString(String raw) {
  if (raw.isEmpty) return raw;
  final neg = raw.startsWith('-');
  final d = neg ? raw.substring(1) : raw;
  if (d.isEmpty) return raw;
  final len = d.length;
  final buf = StringBuffer();
  for (var i = 0; i < len; i++) {
    if (i > 0 && (len - i) % 3 == 0) buf.write(',');
    buf.write(d[i]);
  }
  final out = buf.toString();
  return neg ? '-$out' : out;
}

/// Format crypto amounts with up to 8 fraction digits; trim trailing zeros.
/// Thousands separators are added to the integer part for readability.
String formatCryptoAmount(double v) {
  if (v.isNaN || v.isInfinite) return '';
  if (v == 0) return '0';
  var s = v.toStringAsFixed(8);
  s = s.replaceFirst(RegExp(r'0+$'), '');
  s = s.replaceFirst(RegExp(r'\.$'), '');
  final dot = s.indexOf('.');
  if (dot == -1) return _commaGroupIntString(s);
  final intPart = s.substring(0, dot);
  final frac = s.substring(dot);
  return '${_commaGroupIntString(intPart)}$frac';
}

String formatUsdBase(double v) {
  if (v.isNaN || v.isInfinite) return '';
  return _usdAmount.format(v);
}

double? parseAmountLoose(String raw) {
  final s = raw.trim().replaceAll(',', '');
  if (s.isEmpty) return null;
  return double.tryParse(s);
}

/// USD price of one unit of [code] (USD itself is 1.0).
double usdPerUnit(String code, Map<String, double> rates) {
  if (code == 'USD') return 1.0;
  return rates[code] ?? 1.0;
}

double usdFromCoinAmount(String code, double amount, Map<String, double> rates) {
  return amount * usdPerUnit(code, rates);
}

double coinAmountFromUsd(String code, double usd, Map<String, double> rates) {
  final r = usdPerUnit(code, rates);
  if (r == 0) return 0;
  return usd / r;
}

/// Format amount shown in the field for [code] (USD uses 2 decimals).
String formatAmountForCode(String code, double amountInThatCoin, Map<String, double> rates) {
  if (code == 'USD') return formatUsdBase(amountInThatCoin);
  return formatCryptoAmount(amountInThatCoin);
}
