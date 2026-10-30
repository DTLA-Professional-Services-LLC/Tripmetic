import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

enum DayRelation { same, next, previous }

String labelForDayRelation(DayRelation r) => switch (r) {
      DayRelation.same => 'Same Day',
      DayRelation.next => '+1 Day',
      DayRelation.previous => '-1 Day',
    };

/// Gregorian calendar-day difference: other local date minus base local date.
/// Uses UTC [DateTime] only as a date container (Y-M-D), not as a time zone.
int calendarDayDelta(tz.TZDateTime baseLocal, tz.TZDateTime otherLocal) {
  final b = DateTime.utc(baseLocal.year, baseLocal.month, baseLocal.day);
  final o = DateTime.utc(otherLocal.year, otherLocal.month, otherLocal.day);
  return o.difference(b).inDays;
}

DayRelation dayRelation({
  required tz.TZDateTime baseLocal,
  required tz.TZDateTime otherLocal,
}) {
  final d = calendarDayDelta(baseLocal, otherLocal);
  if (d > 0) return DayRelation.next;
  if (d < 0) return DayRelation.previous;
  return DayRelation.same;
}

class ConvertedSlot {
  const ConvertedSlot({
    required this.timezoneId,
    required this.localTime,
    required this.dayRelation,
  });

  final String timezoneId;
  final tz.TZDateTime localTime;
  final DayRelation dayRelation;
}

class SchedulerComputation {
  SchedulerComputation._({
    required this.baseLocal,
    required this.converted,
  });

  final tz.TZDateTime baseLocal;
  final List<ConvertedSlot> converted;

  static SchedulerComputation compute({
    required String baseTimezoneId,
    required List<String> convertedTimezoneIds,
    required DateTime date,
    required TimeOfDay time,
  }) {
    final baseLoc = tz.getLocation(baseTimezoneId);
    final baseLocal = tz.TZDateTime(
      baseLoc,
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final converted = <ConvertedSlot>[];
    for (final id in convertedTimezoneIds) {
      final dest = tz.getLocation(id);
      final atDest = tz.TZDateTime.from(baseLocal, dest);
      final rel = dayRelation(baseLocal: baseLocal, otherLocal: atDest);
      converted.add(
        ConvertedSlot(
          timezoneId: id,
          localTime: atDest,
          dayRelation: rel,
        ),
      );
    }

    return SchedulerComputation._(baseLocal: baseLocal, converted: converted);
  }
}

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

/// 12-hour clock from [TZDateTime] wall fields only (no device-local reinterpretation).
String formatSchedulerTime(tz.TZDateTime t) {
  final h24 = t.hour;
  var h12 = h24 % 12;
  if (h12 == 0) h12 = 12;
  final mm = t.minute.toString().padLeft(2, '0');
  final ap = h24 >= 12 ? 'PM' : 'AM';
  return '$h12:$mm $ap';
}

/// Long date from [TZDateTime] wall fields in that location.
String formatSchedulerDate(tz.TZDateTime t) {
  final wd = _weekdays[t.weekday - 1];
  final mo = _months[t.month - 1];
  return '$wd, $mo ${t.day}, ${t.year}';
}

/// Compact date without weekday (e.g. dense list rows).
String formatSchedulerDateShort(tz.TZDateTime t) {
  final mo = _months[t.month - 1];
  return '$mo ${t.day}, ${t.year}';
}
