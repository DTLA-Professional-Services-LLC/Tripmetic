import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/scheduler_prefs_store.dart';
import 'scheduler_state.dart';

class SchedulerNotifier extends AsyncNotifier<SchedulerState> {
  @override
  Future<SchedulerState> build() async {
    debugPrint('[scheduler:notifier:load] build() start');
    developer.log('build() start', name: 'scheduler:notifier:load');
    await openSchedulerPrefsBox();
    final initial = SchedulerState.initial();
    final stored = readSchedulerLocations();
    if (stored == null) {
      debugPrint(
        '[scheduler:notifier:load] no valid stored locations; using initial '
        'base=${initial.baseTimezoneId} converted=${initial.convertedTimezoneIds}',
      );
      developer.log(
        'using initial (no store) base=${initial.baseTimezoneId}',
        name: 'scheduler:notifier:load',
      );
      return initial;
    }
    final merged = initial.copyWith(
      baseTimezoneId: stored.base,
      convertedTimezoneIds: stored.converted,
    );
    debugPrint(
      '[scheduler:notifier:load] applied store -> base=${merged.baseTimezoneId} '
      'converted=${merged.convertedTimezoneIds}',
    );
    developer.log(
      'applied store base=${merged.baseTimezoneId}',
      name: 'scheduler:notifier:load',
    );
    return merged;
  }

  SchedulerState get _value => state.requireValue;

  /// Persists the exact [snapshot] written to [state] (avoids any async read of `state` after update).
  Future<void> _saveLocationsToHive(SchedulerState snapshot, String reason) async {
    debugPrint(
      '[scheduler:notifier:save] $reason | base=${snapshot.baseTimezoneId} '
      'converted=${snapshot.convertedTimezoneIds}',
    );
    developer.log(
      '$reason | base=${snapshot.baseTimezoneId}',
      name: 'scheduler:notifier:save',
    );
    try {
      await saveSchedulerLocations(
        baseTimezoneId: snapshot.baseTimezoneId,
        convertedTimezoneIds: snapshot.convertedTimezoneIds,
      );
      debugPrint('[scheduler:notifier:save] completed OK ($reason)');
      developer.log('completed OK ($reason)', name: 'scheduler:notifier:save');
    } catch (e, st) {
      debugPrint('[scheduler:notifier:save] FAILED ($reason): $e\n$st');
      developer.log('FAILED ($reason): $e', name: 'scheduler:notifier:save', error: e, stackTrace: st);
    }
  }

  void setBaseTimezone(String id) {
    final next = _value.copyWith(baseTimezoneId: id);
    state = AsyncValue.data(next);
    unawaited(_saveLocationsToHive(next, 'setBaseTimezone'));
  }

  void setConvertedAt(int index, String timezoneId) {
    final list = List<String>.from(_value.convertedTimezoneIds);
    list[index] = timezoneId;
    final next = _value.copyWith(convertedTimezoneIds: list);
    state = AsyncValue.data(next);
    unawaited(_saveLocationsToHive(next, 'setConvertedAt[$index]'));
  }

  void setDate(DateTime date) {
    state = AsyncValue.data(_value.copyWith(date: DateUtils.dateOnly(date)));
  }

  /// Snaps to 0.5h; range [0, 24].
  void setSelectedMeetingHours(double hours) {
    final clamped = hours.clamp(0.0, 24.0);
    final snapped = (clamped * 2).round() / 2.0;
    state = AsyncValue.data(_value.copyWith(selectedMeetingHours: snapped));
  }

  void setTimeFromTimeOfDay(TimeOfDay time) {
    setSelectedMeetingHours(hoursFromTimeOfDay(time));
  }
}

final schedulerProvider =
    AsyncNotifierProvider<SchedulerNotifier, SchedulerState>(SchedulerNotifier.new);
