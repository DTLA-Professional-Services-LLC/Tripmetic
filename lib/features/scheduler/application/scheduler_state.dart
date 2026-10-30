import 'package:flutter/material.dart';

import '../data/timezone_catalog.dart';

/// Riverpod state for the Global Scheduler (base TZ, date, meeting time).
class SchedulerState {
  const SchedulerState({
    required this.baseTimezoneId,
    required this.convertedTimezoneIds,
    required this.date,
    required this.selectedMeetingHours,
  });

  final String baseTimezoneId;
  final List<String> convertedTimezoneIds;
  final DateTime date;

  /// 0.0–24.0 in 0.5h steps. `24.0` is midnight (same calendar day as 0:00).
  final double selectedMeetingHours;

  TimeOfDay get timeOfDay {
    if (selectedMeetingHours >= 24.0 - 1e-9) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
    final totalMinutes = (selectedMeetingHours.clamp(0.0, 24.0) * 60).round().clamp(0, 24 * 60);
    final hour = (totalMinutes ~/ 60) % 24;
    final minute = totalMinutes % 60;
    return TimeOfDay(hour: hour, minute: minute);
  }

  SchedulerState copyWith({
    String? baseTimezoneId,
    List<String>? convertedTimezoneIds,
    DateTime? date,
    double? selectedMeetingHours,
  }) {
    return SchedulerState(
      baseTimezoneId: baseTimezoneId ?? this.baseTimezoneId,
      convertedTimezoneIds: convertedTimezoneIds ?? this.convertedTimezoneIds,
      date: date ?? this.date,
      selectedMeetingHours: selectedMeetingHours ?? this.selectedMeetingHours,
    );
  }

  static SchedulerState initial() {
    final now = DateTime.now();
    final raw = now.hour + now.minute / 60.0;
    var h = (raw * 2).round() / 2.0;
    h = h.clamp(0.0, 24.0);
    return SchedulerState(
      baseTimezoneId: kDefaultBaseTimezone,
      convertedTimezoneIds: List<String>.from(kDefaultConvertedTimezones),
      date: DateUtils.dateOnly(now),
      selectedMeetingHours: h,
    );
  }
}

double hoursFromTimeOfDay(TimeOfDay t) => t.hour + t.minute / 60.0;
