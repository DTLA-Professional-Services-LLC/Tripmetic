import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:tripmetic/features/scheduler/application/availability.dart';

void main() {
  setUpAll(tz_data.initializeTimeZones);

  group('availabilityForDecimalHour', () {
    test('boundaries: sleeping vs marginal at 6:00', () {
      expect(availabilityForDecimalHour(5.99), AvailabilityStatus.sleeping);
      expect(availabilityForDecimalHour(6.0), AvailabilityStatus.marginal);
    });

    test('boundaries: marginal vs working at 8:00', () {
      expect(availabilityForDecimalHour(7.99), AvailabilityStatus.marginal);
      expect(availabilityForDecimalHour(8.0), AvailabilityStatus.working);
    });

    test('boundaries: working vs marginal at 18:00', () {
      expect(availabilityForDecimalHour(17.99), AvailabilityStatus.working);
      expect(availabilityForDecimalHour(18.0), AvailabilityStatus.marginal);
    });

    test('boundaries: marginal vs sleeping at 22:00', () {
      expect(availabilityForDecimalHour(21.99), AvailabilityStatus.marginal);
      expect(availabilityForDecimalHour(22.0), AvailabilityStatus.sleeping);
    });

    test('wraps negative and >24', () {
      expect(availabilityForDecimalHour(-2), AvailabilityStatus.sleeping); // 22:00 local
      expect(availabilityForDecimalHour(26), AvailabilityStatus.sleeping); // 02:00 local
    });
  });

  group('availabilityForLocalTime', () {
    test('uses wall time in zone', () {
      final loc = tz.getLocation('America/New_York');
      final t = tz.TZDateTime(loc, 2026, 6, 1, 14, 30);
      expect(availabilityForLocalTime(t), AvailabilityStatus.working);
    });
  });
}
