import 'unit_category.dart';

/// Identifiers for units within a category (stable keys for UI + conversion).
abstract final class UnitIds {
  static const ft = 'ft';
  static const inch = 'in';
  static const cm = 'cm';
  static const m = 'm';

  static const lb = 'lb';
  static const oz = 'oz';
  static const kg = 'kg';
  static const g = 'g';

  static const gal = 'gal';
  static const l = 'L';
  static const ml = 'ml';
  static const flOz = 'fl_oz';

  static const mi = 'mi';
  static const km = 'km';
  static const yd = 'yd';

  /// Area (canonical: square meters).
  static const sqM = 'sq_m';
  static const sqCm = 'sq_cm';
  static const sqFt = 'sq_ft';
  static const sqYd = 'sq_yd';
  static const sqIn = 'sq_in';
  static const sqKm = 'sq_km';
  static const acre = 'acre';
  static const hectare = 'ha';

  static const fahrenheit = 'F';
  static const celsius = 'C';
}

/// Metadata for one row in the units list.
class UnitRow {
  const UnitRow({
    required this.id,
    required this.symbol,
  });

  final String id;
  final String symbol;
}

List<UnitRow> unitsForCategory(UnitCategory c) => switch (c) {
      UnitCategory.length => const [
          UnitRow(id: UnitIds.ft, symbol: 'ft'),
          UnitRow(id: UnitIds.inch, symbol: 'in'),
          UnitRow(id: UnitIds.cm, symbol: 'cm'),
          UnitRow(id: UnitIds.m, symbol: 'm'),
        ],
      UnitCategory.weight => const [
          UnitRow(id: UnitIds.lb, symbol: 'lb'),
          UnitRow(id: UnitIds.oz, symbol: 'oz'),
          UnitRow(id: UnitIds.kg, symbol: 'kg'),
          UnitRow(id: UnitIds.g, symbol: 'g'),
        ],
      UnitCategory.volume => const [
          UnitRow(id: UnitIds.gal, symbol: 'gal'),
          UnitRow(id: UnitIds.l, symbol: 'L'),
          UnitRow(id: UnitIds.ml, symbol: 'ml'),
          UnitRow(id: UnitIds.flOz, symbol: 'fl oz'),
        ],
      UnitCategory.distance => const [
          UnitRow(id: UnitIds.mi, symbol: 'mi'),
          UnitRow(id: UnitIds.km, symbol: 'km'),
          UnitRow(id: UnitIds.m, symbol: 'm'),
          UnitRow(id: UnitIds.yd, symbol: 'yd'),
          UnitRow(id: UnitIds.cm, symbol: 'cm'),
          UnitRow(id: UnitIds.ft, symbol: 'ft'),
        ],
      UnitCategory.area => const [
          UnitRow(id: UnitIds.sqM, symbol: 'm²'),
          UnitRow(id: UnitIds.sqCm, symbol: 'cm²'),
          UnitRow(id: UnitIds.sqFt, symbol: 'ft²'),
          UnitRow(id: UnitIds.sqYd, symbol: 'yd²'),
          UnitRow(id: UnitIds.sqIn, symbol: 'in²'),
          UnitRow(id: UnitIds.sqKm, symbol: 'km²'),
          UnitRow(id: UnitIds.hectare, symbol: 'ha'),
          UnitRow(id: UnitIds.acre, symbol: 'ac'),
        ],
      UnitCategory.temperature => const [
          UnitRow(id: UnitIds.fahrenheit, symbol: '°F'),
          UnitRow(id: UnitIds.celsius, symbol: '°C'),
        ],
    };

/// Canonical internal value:
/// - Length / Distance: meters
/// - Area: square meters
/// - Weight: kilograms
/// - Volume: liters
/// - Temperature: degrees Celsius
abstract final class UnitConversion {
  /// Converts a display value in [unitId] to canonical form for [category].
  static double toCanonical(UnitCategory category, String unitId, double v) {
    switch (category) {
      case UnitCategory.length:
        return switch (unitId) {
          UnitIds.ft => v * 0.3048,
          UnitIds.inch => v * 0.0254,
          UnitIds.cm => v * 0.01,
          UnitIds.m => v,
          _ => v,
        };
      case UnitCategory.weight:
        return switch (unitId) {
          UnitIds.lb => v * 0.45359237,
          UnitIds.oz => v * 0.028349523125,
          UnitIds.kg => v,
          UnitIds.g => v * 0.001,
          _ => v,
        };
      case UnitCategory.volume:
        return switch (unitId) {
          UnitIds.gal => v * 3.785411784,
          UnitIds.l => v,
          UnitIds.ml => v * 0.001,
          UnitIds.flOz => v * 0.0295735295625,
          _ => v,
        };
      case UnitCategory.distance:
        return switch (unitId) {
          UnitIds.m => v,
          UnitIds.yd => v * 0.9144,
          UnitIds.cm => v * 0.01,
          UnitIds.ft => v * 0.3048,
          UnitIds.mi => v * 1609.344,
          UnitIds.km => v * 1000.0,
          _ => v,
        };
      case UnitCategory.area:
        return switch (unitId) {
          UnitIds.sqM => v,
          UnitIds.sqCm => v * 1e-4,
          UnitIds.sqFt => v * 0.09290304,
          UnitIds.sqYd => v * 0.83612736,
          UnitIds.sqIn => v * 0.00064516,
          UnitIds.sqKm => v * 1e6,
          UnitIds.hectare => v * 10000.0,
          UnitIds.acre => v * 4046.8564224,
          _ => v,
        };
      case UnitCategory.temperature:
        return switch (unitId) {
          UnitIds.fahrenheit => (v - 32.0) * 5.0 / 9.0,
          UnitIds.celsius => v,
          _ => v,
        };
    }
  }

  /// Converts canonical value back to [unitId] for display.
  static double fromCanonical(UnitCategory category, String unitId, double c) {
    switch (category) {
      case UnitCategory.length:
        return switch (unitId) {
          UnitIds.ft => c / 0.3048,
          UnitIds.inch => c / 0.0254,
          UnitIds.cm => c / 0.01,
          UnitIds.m => c,
          _ => c,
        };
      case UnitCategory.weight:
        return switch (unitId) {
          UnitIds.lb => c / 0.45359237,
          UnitIds.oz => c / 0.028349523125,
          UnitIds.kg => c,
          UnitIds.g => c / 0.001,
          _ => c,
        };
      case UnitCategory.volume:
        return switch (unitId) {
          UnitIds.gal => c / 3.785411784,
          UnitIds.l => c,
          UnitIds.ml => c / 0.001,
          UnitIds.flOz => c / 0.0295735295625,
          _ => c,
        };
      case UnitCategory.distance:
        return switch (unitId) {
          UnitIds.m => c,
          UnitIds.yd => c / 0.9144,
          UnitIds.cm => c / 0.01,
          UnitIds.ft => c / 0.3048,
          UnitIds.mi => c / 1609.344,
          UnitIds.km => c / 1000.0,
          _ => c,
        };
      case UnitCategory.area:
        return switch (unitId) {
          UnitIds.sqM => c,
          UnitIds.sqCm => c / 1e-4,
          UnitIds.sqFt => c / 0.09290304,
          UnitIds.sqYd => c / 0.83612736,
          UnitIds.sqIn => c / 0.00064516,
          UnitIds.sqKm => c / 1e6,
          UnitIds.hectare => c / 10000.0,
          UnitIds.acre => c / 4046.8564224,
          _ => c,
        };
      case UnitCategory.temperature:
        return switch (unitId) {
          UnitIds.fahrenheit => c * 9.0 / 5.0 + 32.0,
          UnitIds.celsius => c,
          _ => c,
        };
    }
  }

  /// Reasonable display precision per category (not temperature: handled separately).
  static int fractionDigits(UnitCategory category, String unitId) {
    if (category == UnitCategory.temperature) return 2;
    if (category == UnitCategory.length && unitId == UnitIds.inch) return 4;
    if (category == UnitCategory.weight && unitId == UnitIds.oz) return 4;
    if (category == UnitCategory.volume && (unitId == UnitIds.ml || unitId == UnitIds.flOz)) {
      return 4;
    }
    if (category == UnitCategory.area &&
        (unitId == UnitIds.sqCm || unitId == UnitIds.sqIn || unitId == UnitIds.sqFt)) {
      return 8;
    }
    return 6;
  }

  static String formatValue(UnitCategory category, String unitId, double v) {
    if (v.isNaN || v.isInfinite) return '';
    if (category == UnitCategory.temperature) {
      return v.toStringAsFixed(2);
    }
    final d = fractionDigits(category, unitId);
    var s = v.toStringAsFixed(d);
    s = s.replaceFirst(RegExp(r'0+$'), '');
    s = s.replaceFirst(RegExp(r'\.$'), '');
    return s;
  }
}

/// Parses user input; returns null if not a valid number.
double? parseUnitInput(String raw) {
  final s = raw.trim().replaceAll(',', '');
  if (s.isEmpty) return null;
  return double.tryParse(s);
}
