import 'dart:math' as math;

import 'bucket_list_geo.dart';
import 'travel_constants.dart';

/// Approximate geographic centroids for nearest-state lookup (offline).
const Map<String, (double lat, double lng)> kUsStateCentroids =
    <String, (double, double)>{
  'Alabama': (32.8067, -86.7911),
  'Alaska': (61.3707, -152.4044),
  'Arizona': (33.7298, -111.4312),
  'Arkansas': (34.9697, -92.3731),
  'California': (36.1162, -119.6816),
  'Colorado': (39.0598, -105.3111),
  'Connecticut': (41.5978, -72.7554),
  'Delaware': (39.3185, -75.5071),
  'District of Columbia': (38.9072, -77.0369),
  'Florida': (27.7663, -81.6868),
  'Georgia': (33.0406, -83.6431),
  'Hawaii': (21.0943, -157.4983),
  'Idaho': (44.2405, -114.4788),
  'Illinois': (40.3495, -88.9861),
  'Indiana': (39.8494, -86.2583),
  'Iowa': (42.0115, -93.2105),
  'Kansas': (38.5266, -96.7265),
  'Kentucky': (37.6681, -84.6701),
  'Louisiana': (31.1695, -91.8678),
  'Maine': (44.6939, -69.3819),
  'Maryland': (39.0639, -76.8021),
  'Massachusetts': (42.2302, -71.5301),
  'Michigan': (43.3266, -84.5361),
  'Minnesota': (45.6945, -93.9002),
  'Mississippi': (32.7416, -89.6787),
  'Missouri': (38.4561, -92.2884),
  'Montana': (46.9219, -110.4544),
  'Nebraska': (41.4925, -99.9018),
  'Nevada': (38.3135, -117.0554),
  'New Hampshire': (43.4525, -71.5639),
  'New Jersey': (40.2989, -74.5210),
  'New Mexico': (34.8405, -106.2485),
  'New York': (42.1657, -74.9481),
  'North Carolina': (35.6301, -79.8064),
  'North Dakota': (47.5289, -99.7840),
  'Ohio': (40.3888, -82.7649),
  'Oklahoma': (35.5653, -96.9289),
  'Oregon': (44.5721, -122.0709),
  'Pennsylvania': (40.5908, -77.2098),
  'Rhode Island': (41.6809, -71.5118),
  'South Carolina': (33.8569, -80.9450),
  'South Dakota': (44.2998, -99.4388),
  'Tennessee': (35.7478, -86.6923),
  'Texas': (31.0545, -97.5635),
  'Utah': (40.1500, -111.8624),
  'Vermont': (44.0459, -72.7107),
  'Virginia': (37.7693, -78.1700),
  'Washington': (47.4009, -121.4905),
  'West Virginia': (38.4912, -80.9545),
  'Wisconsin': (44.2685, -89.6165),
  'Wyoming': (42.7560, -107.3025),
};

bool _inUsBounds(double lat, double lng) =>
    lat >= 17.5 && lat <= 72.5 && lng >= -179.5 && lng <= -65.0;

double _haversineKm(double lat1, double lng1, double lat2, double lng2) {
  const r = 6371.0;
  final dLat = _toRad(lat2 - lat1);
  final dLng = _toRad(lng2 - lng1);
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_toRad(lat1)) *
          math.cos(_toRad(lat2)) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return r * c;
}

double _toRad(double deg) => deg * math.pi / 180.0;

/// Infers a US state/province name from coordinates (for metrics + popular toggles).
String? inferUsStateFromCoordinates(double latitude, double longitude) {
  if (!_inUsBounds(latitude, longitude)) return null;

  String? nearest;
  var bestKm = double.infinity;
  for (final entry in kUsStateCentroids.entries) {
    final c = entry.value;
    final km = _haversineKm(latitude, longitude, c.$1, c.$2);
    if (km < bestKm) {
      bestKm = km;
      nearest = entry.key;
    }
  }
  return nearest == null ? null : resolveUsStateKey(nearest);
}

/// Resolves geocoder [administrativeArea] (e.g. "IL") to a canonical US state name.
String? resolveUsStateFromAdminArea(String? administrativeArea) {
  if (administrativeArea == null) return null;
  final raw = administrativeArea.trim();
  if (raw.isEmpty) return null;

  final byName = resolveUsStateKey(raw);
  if (byName != null) return byName;

  const abbreviations = <String, String>{
    'AL': 'Alabama',
    'AK': 'Alaska',
    'AZ': 'Arizona',
    'AR': 'Arkansas',
    'CA': 'California',
    'CO': 'Colorado',
    'CT': 'Connecticut',
    'DE': 'Delaware',
    'DC': 'District of Columbia',
    'FL': 'Florida',
    'GA': 'Georgia',
    'HI': 'Hawaii',
    'ID': 'Idaho',
    'IL': 'Illinois',
    'IN': 'Indiana',
    'IA': 'Iowa',
    'KS': 'Kansas',
    'KY': 'Kentucky',
    'LA': 'Louisiana',
    'ME': 'Maine',
    'MD': 'Maryland',
    'MA': 'Massachusetts',
    'MI': 'Michigan',
    'MN': 'Minnesota',
    'MS': 'Mississippi',
    'MO': 'Missouri',
    'MT': 'Montana',
    'NE': 'Nebraska',
    'NV': 'Nevada',
    'NH': 'New Hampshire',
    'NJ': 'New Jersey',
    'NM': 'New Mexico',
    'NY': 'New York',
    'NC': 'North Carolina',
    'ND': 'North Dakota',
    'OH': 'Ohio',
    'OK': 'Oklahoma',
    'OR': 'Oregon',
    'PA': 'Pennsylvania',
    'RI': 'Rhode Island',
    'SC': 'South Carolina',
    'SD': 'South Dakota',
    'TN': 'Tennessee',
    'TX': 'Texas',
    'UT': 'Utah',
    'VT': 'Vermont',
    'VA': 'Virginia',
    'WA': 'Washington',
    'WV': 'West Virginia',
    'WI': 'Wisconsin',
    'WY': 'Wyoming',
  };

  final mapped = abbreviations[raw.toUpperCase()];
  if (mapped == null) return null;
  return resolveUsStateKey(mapped);
}

bool destinationCountryIsUnitedStates(String country) =>
    country.trim() == kCountryUnitedStates;
