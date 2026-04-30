import 'size_conversion_data.dart';
import 'size_input_column.dart';

String normalizeSizeToken(String raw) {
  var s = raw.trim();
  if (s.isEmpty) return '';
  s = s.replaceAll('×', 'x');
  s = s.toLowerCase();
  s = s.replaceAll(',', '.');
  s = s.replaceAll(RegExp(r'\s+'), '');
  s = s.replaceAll('½', '.5');
  s = s.replaceAll('⅓', '.33');
  s = s.replaceAll('⅔', '.67');
  return s;
}

bool _tokensMatch(String cell, String normalizedInput) {
  final c = normalizeSizeToken(cell);
  if (c.isEmpty) return false;
  if (c == normalizedInput) return true;
  final dn = double.tryParse(normalizedInput);
  final dc = double.tryParse(c);
  if (dn != null && dc != null && (dn - dc).abs() < 1e-6) return true;
  return false;
}

String _cell(SizeRow r, SizeInputColumn col) {
  return switch (col) {
    SizeInputColumn.us => r.us,
    SizeInputColumn.uk => r.uk,
    SizeInputColumn.eu => r.eu,
    SizeInputColumn.jp => r.jp,
    SizeInputColumn.mixed => '',
  };
}

List<SizeInputColumn> _order(SizeInputColumn primary) {
  return switch (primary) {
    SizeInputColumn.us => [
      SizeInputColumn.us,
      SizeInputColumn.eu,
      SizeInputColumn.uk,
      SizeInputColumn.jp,
    ],
    SizeInputColumn.uk => [
      SizeInputColumn.uk,
      SizeInputColumn.eu,
      SizeInputColumn.us,
      SizeInputColumn.jp,
    ],
    SizeInputColumn.eu => [
      SizeInputColumn.eu,
      SizeInputColumn.us,
      SizeInputColumn.uk,
      SizeInputColumn.jp,
    ],
    SizeInputColumn.jp => [
      SizeInputColumn.jp,
      SizeInputColumn.eu,
      SizeInputColumn.us,
      SizeInputColumn.uk,
    ],
    SizeInputColumn.mixed => [
      SizeInputColumn.eu,
      SizeInputColumn.us,
      SizeInputColumn.uk,
      SizeInputColumn.jp,
    ],
  };
}

/// Rows for lookup; [SizeCategory.mensJeansWaist] reuses men's pants (waist inches).
List<SizeRow>? _rowsForCategory(SizeCategory category) {
  return switch (category) {
    SizeCategory.mensJeansWaist => kSizeCatalog[SizeCategory.mensPants],
    _ => kSizeCatalog[category],
  };
}

/// If input is `38x32` / `38×32`, use waist (W) or inseam (L) part for jeans categories.
String _effectiveRawInput(SizeCategory category, String rawInput) {
  final t = rawInput.trim().replaceAll('×', 'x');
  final m = RegExp(r'^(\d{1,2})[xX](\d{2})$').firstMatch(t);
  if (m == null) return rawInput;
  return switch (category) {
    SizeCategory.mensJeansWaist => m.group(1)!,
    SizeCategory.mensJeansInseam => m.group(2)!,
    _ => rawInput,
  };
}

/// Finds a catalog row by matching [rawInput] against columns implied by [primary].
SizeRow? lookupSizeRow({
  required SizeCategory category,
  required SizeInputColumn primary,
  required String rawInput,
}) {
  final effective = _effectiveRawInput(category, rawInput);
  final n = normalizeSizeToken(effective);
  if (n.isEmpty) return null;
  final rows = _rowsForCategory(category);
  if (rows == null || rows.isEmpty) return null;

  for (final col in _order(primary)) {
    for (final r in rows) {
      final cell = _cell(r, col);
      if (cell.isEmpty) continue;
      if (_tokensMatch(cell, n)) return r;
    }
  }
  return null;
}
