import 'package:timezone/timezone.dart' as tz;

List<String>? _sortedIdsCache;

/// All IANA zone ids from the bundled tz database, sorted for display/search.
List<String> sortedTimezoneIds() {
  if (_sortedIdsCache != null) return _sortedIdsCache!;
  final keys = tz.timeZoneDatabase.locations.keys.toList()..sort();
  _sortedIdsCache = keys;
  return keys;
}

const String kDefaultBaseTimezone = 'America/Los_Angeles';

/// Default converted rows (Manila, Hanoi, New York, London).
const List<String> kDefaultConvertedTimezones = [
  'Asia/Manila',
  'Asia/Ho_Chi_Minh',
  'America/New_York',
  'Europe/London',
];
