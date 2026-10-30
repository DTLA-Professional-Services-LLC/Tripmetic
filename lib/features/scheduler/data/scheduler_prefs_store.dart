import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/timezone.dart' as tz;

import 'timezone_catalog.dart';

const String schedulerPrefsBoxName = 'scheduler_prefs';

/// Current on-disk format: JSON string for reliable round-trip of string lists.
const String _kPayloadKey = 'scheduler_locations_v2';

/// Legacy Hive keys (v1).
const String _kLegacyBaseTimezoneId = 'baseTimezoneId';
const String _kLegacyConvertedTimezoneIds = 'convertedTimezoneIds';

bool _isValidTimezoneId(String id) => tz.timeZoneDatabase.locations.containsKey(id);

List<String> _normalizeConvertedList(List<dynamic>? raw) {
  final defaults = List<String>.from(kDefaultConvertedTimezones);
  final list = raw?.map((e) => e.toString()).toList() ?? const <String>[];
  return List<String>.generate(defaults.length, (i) {
    final id = i < list.length ? list[i] : defaults[i];
    return _isValidTimezoneId(id) ? id : defaults[i];
  });
}

({String base, List<String> converted})? _tryParseJsonPayload(String jsonStr) {
  try {
    final decoded = jsonDecode(jsonStr);
    if (decoded is! Map) return null;
    final baseRaw = decoded['base'];
    final convRaw = decoded['converted'];
    if (baseRaw is! String) return null;
    final base = baseRaw;
    if (!_isValidTimezoneId(base)) return null;
    final converted = _normalizeConvertedList(
      convRaw is List ? List<dynamic>.from(convRaw) : null,
    );
    return (base: base, converted: converted);
  } catch (_) {
    return null;
  }
}

/// Reads legacy separate keys (pre-JSON format).
({String base, List<String> converted})? _readLegacy(Box<dynamic> box) {
  if (!box.containsKey(_kLegacyBaseTimezoneId)) return null;

  final baseRaw = box.get(_kLegacyBaseTimezoneId);
  final base = baseRaw is String ? baseRaw : null;
  if (base == null || !_isValidTimezoneId(base)) {
    return null;
  }

  final rawConverted = box.get(_kLegacyConvertedTimezoneIds);
  final list = rawConverted is List ? List<dynamic>.from(rawConverted) : null;
  final converted = _normalizeConvertedList(list);
  return (base: base, converted: converted);
}

Future<void> openSchedulerPrefsBox() async {
  if (!Hive.isBoxOpen(schedulerPrefsBoxName)) {
    await Hive.openBox<dynamic>(schedulerPrefsBoxName);
  }
}

/// Reads saved base + converter cities. Returns `null` if nothing valid is stored.
///
/// Call only after [openSchedulerPrefsBox] and [tz.initializeTimeZones] (or
/// `tz_data.initializeTimeZones()`) so ids can be validated.
void _logRead(String message) {
  debugPrint('[scheduler.hive:read] $message');
  developer.log(message, name: 'scheduler.hive:read');
}

({String base, List<String> converted})? readSchedulerLocations() {
  if (!Hive.isBoxOpen(schedulerPrefsBoxName)) {
    _logRead('box not open; returning null');
    return null;
  }
  final box = Hive.box<dynamic>(schedulerPrefsBoxName);

  final jsonStr = box.get(_kPayloadKey);
  if (jsonStr is String) {
    _logRead('raw JSON at $_kPayloadKey: $jsonStr');
    final parsed = _tryParseJsonPayload(jsonStr);
    if (parsed == null) {
      _logRead('JSON parse/validation failed; returning null');
    } else {
      _logRead('parsed base=${parsed.base} converted=${parsed.converted}');
    }
    return parsed;
  }

  _logRead('no v2 key; trying legacy');
  final legacy = _readLegacy(box);
  if (legacy != null) {
    _logRead('legacy base=${legacy.base} converted=${legacy.converted}');
  } else {
    _logRead('legacy read returned null');
  }
  return legacy;
}

/// Persists locations as JSON and flushes to disk so a force-kill does not drop data.
Future<void> saveSchedulerLocations({
  required String baseTimezoneId,
  required List<String> convertedTimezoneIds,
}) async {
  if (!Hive.isBoxOpen(schedulerPrefsBoxName)) {
    await openSchedulerPrefsBox();
  }
  final box = Hive.box<dynamic>(schedulerPrefsBoxName);
  final payload = jsonEncode({
    'base': baseTimezoneId,
    'converted': convertedTimezoneIds,
  });
  debugPrint('[scheduler.hive:write] JSON -> $payload');
  developer.log('JSON -> $payload', name: 'scheduler.hive:write');
  try {
    await box.put(_kPayloadKey, payload);
    await box.delete(_kLegacyBaseTimezoneId);
    await box.delete(_kLegacyConvertedTimezoneIds);
    await box.flush();
    debugPrint('[scheduler.hive:write] put+flush done for key=$_kPayloadKey');
    developer.log('put+flush done for key=$_kPayloadKey', name: 'scheduler.hive:write');
  } catch (e, st) {
    debugPrint('[scheduler.hive:write] ERROR $e\n$st');
    developer.log('ERROR $e', name: 'scheduler.hive:write', error: e, stackTrace: st);
    rethrow;
  }
}
