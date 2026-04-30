import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'scheduler_state.dart';

class SchedulerNotifier extends StateNotifier<SchedulerState> {
  SchedulerNotifier() : super(SchedulerState.initial());

  void setBaseTimezone(String id) {
    state = state.copyWith(baseTimezoneId: id);
  }

  void setConvertedAt(int index, String timezoneId) {
    final next = List<String>.from(state.convertedTimezoneIds);
    next[index] = timezoneId;
    state = state.copyWith(convertedTimezoneIds: next);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: DateUtils.dateOnly(date));
  }

  /// Snaps to 0.5h; range [0, 24].
  void setSelectedMeetingHours(double hours) {
    final clamped = hours.clamp(0.0, 24.0);
    final snapped = (clamped * 2).round() / 2.0;
    state = state.copyWith(selectedMeetingHours: snapped);
  }

  void setTimeFromTimeOfDay(TimeOfDay time) {
    setSelectedMeetingHours(hoursFromTimeOfDay(time));
  }
}

final schedulerProvider = StateNotifierProvider<SchedulerNotifier, SchedulerState>((ref) {
  return SchedulerNotifier();
});
