import 'package:intl/intl.dart';

/// USD display with thousands separators (e.g. large VND-equivalent totals typed as dollars).
String formatUsdAmount(double amount) {
  if (amount.isNaN || amount.isInfinite) return r'$0.00';
  return NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 2,
  ).format(amount);
}

/// Parse bill input: strips commas, whitespace, and leading currency symbols.
double? parseBillInput(String raw) {
  var s = raw.trim().replaceAll(',', '').replaceAll(RegExp(r'\s+'), '');
  s = s.replaceAll(r'$', '');
  if (s.isEmpty) return null;
  return double.tryParse(s);
}
