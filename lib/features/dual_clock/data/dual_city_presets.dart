import '../domain/dual_city_preset.dart';
import 'dual_city_timezone_catalog.dart';

/// Comprehensive global city → IANA list for dual-clock widget configuration.
List<DualCityPreset> get kDualCityPresets => dualCityPresetsSorted;

DualCityPreset dualCityPresetByLabel(String label, DualCityPreset fallback) {
  for (final p in dualCityPresetsSorted) {
    if (p.label == label) return p;
  }
  return fallback;
}

DualCityPreset get kDualClockDefaultCity1 =>
    dualCityPresetByLabel('Los Angeles', dualCityPresetsSorted.first);

DualCityPreset get kDualClockDefaultCity2 =>
    dualCityPresetByLabel('New York', dualCityPresetsSorted.first);
