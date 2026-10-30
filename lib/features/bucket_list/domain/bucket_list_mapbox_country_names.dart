/// Maps canonical app country names ([TravelDestination.country]) to typical
/// `name_en` values in Mapbox `country-boundaries-v1` tiles (not all differ).
const Map<String, String> kAppCountryToMapboxNameEn = <String, String>{
  'United States': 'United States of America',
  'Russia': 'Russia',
  'South Korea': 'South Korea',
  'North Korea': 'North Korea',
  'Czech Republic': 'Czechia',
  'Democratic Republic of the Congo': 'Democratic Republic of the Congo',
  'Congo': 'Republic of the Congo',
};

/// Best-effort English name used by the vector tile `name_en` field.
String mapAppCountryToMapboxNameEn(String appCountry) {
  final t = appCountry.trim();
  if (t.isEmpty) return t;
  return kAppCountryToMapboxNameEn[t] ?? t;
}

/// Labels to match against Mapbox `country_boundaries` `name_en` for one app country.
/// Multiple synonyms cover tileset differences (e.g. United States vs United States of America).
List<String> mapAppCountryToMapboxNameEnSynonyms(String appCountry) {
  final t = appCountry.trim();
  if (t.isEmpty) return const <String>[];

  final primary = mapAppCountryToMapboxNameEn(t);
  final out = <String>{primary};
  if (primary != t) {
    out.add(t);
  }
  if (t == 'United States') {
    out
      ..add('United States')
      ..add('United States of America');
  }
  return out.toList(growable: false);
}
