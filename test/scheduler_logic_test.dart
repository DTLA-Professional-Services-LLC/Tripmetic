import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:tripmetic/features/scheduler/application/scheduler_logic.dart';

void main() {
  setUpAll(tz_data.initializeTimeZones);

  test('Manila Apr 15 3am is LA Apr 14 noon; badge is previous day for LA', () {
    final la = tz.getLocation('America/Los_Angeles');
    final mnl = tz.getLocation('Asia/Manila');
    final manilaLocal = tz.TZDateTime(mnl, 2026, 4, 15, 3, 0);
    final laLocal = tz.TZDateTime.from(manilaLocal, la);
    expect(laLocal.day, 14);
    expect(laLocal.hour, 12);

    final rel = dayRelation(baseLocal: manilaLocal, otherLocal: laLocal);
    expect(rel, DayRelation.previous);
    expect(calendarDayDelta(manilaLocal, laLocal), -1);
  });

  test('LA Apr 14 10pm -> Manila next calendar day', () {
    final c = SchedulerComputation.compute(
      baseTimezoneId: 'America/Los_Angeles',
      convertedTimezoneIds: const ['Asia/Manila'],
      date: DateTime.utc(2026, 4, 14),
      time: const TimeOfDay(hour: 22, minute: 0),
    );
    final m = c.converted.single;
    expect(m.localTime.day, 15);
    expect(m.dayRelation, DayRelation.next);
  });

  test('LA Apr 15 3am -> Manila same calendar day (evening)', () {
    final c = SchedulerComputation.compute(
      baseTimezoneId: 'America/Los_Angeles',
      convertedTimezoneIds: const ['Asia/Manila', 'Asia/Ho_Chi_Minh'],
      date: DateTime.utc(2026, 4, 15),
      time: const TimeOfDay(hour: 3, minute: 0),
    );
    expect(c.baseLocal.day, 15);
    final manila = c.converted.firstWhere((s) => s.timezoneId == 'Asia/Manila');
    final hcm = c.converted.firstWhere((s) => s.timezoneId == 'Asia/Ho_Chi_Minh');
    expect(manila.localTime.day, 15);
    expect(manila.localTime.hour, 18);
    expect(hcm.localTime.day, 15);
    expect(manila.dayRelation, DayRelation.same);
    expect(hcm.dayRelation, DayRelation.same);
  });
}
