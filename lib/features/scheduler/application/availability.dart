import 'package:timezone/timezone.dart' as tz;

/// Local-time-of-day availability for meeting overlap visualization.
enum AvailabilityStatus {
  /// 8:00 AM – 6:00 PM local
  working,

  /// 6:00 AM – 8:00 AM and 6:00 PM – 10:00 PM local
  marginal,

  /// 10:00 PM – 6:00 AM local
  sleeping,
}

String labelForAvailability(AvailabilityStatus s) => switch (s) {
      AvailabilityStatus.working => 'Good',
      AvailabilityStatus.marginal => 'OK',
      AvailabilityStatus.sleeping => 'Off-hours',
    };

/// Uses wall-clock hour and minute in [t]'s zone (decimal hours from midnight).
AvailabilityStatus availabilityForLocalTime(tz.TZDateTime t) {
  final h = t.hour + t.minute / 60.0 + t.second / 3600.0;
  return availabilityForDecimalHour(h);
}

/// [h] is hours from midnight (any value; normalized mod 24).
AvailabilityStatus availabilityForDecimalHour(double h) {
  var x = h % 24.0;
  if (x < 0) {
    x += 24.0;
  }
  if (x >= 22 || x < 6) {
    return AvailabilityStatus.sleeping;
  }
  if (x >= 6 && x < 8) {
    return AvailabilityStatus.marginal;
  }
  if (x >= 8 && x < 18) {
    return AvailabilityStatus.working;
  }
  return AvailabilityStatus.marginal;
}
