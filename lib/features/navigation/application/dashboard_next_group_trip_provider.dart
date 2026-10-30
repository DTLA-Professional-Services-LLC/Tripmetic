import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group_planner/application/group_planner_providers.dart';
import '../../group_planner/domain/group_trip_list_item.dart';

/// Closest relevant group trip for the dashboard: not ended yet, soonest [GroupTrip.startDate].
final dashboardNextGroupTripProvider =
    Provider<AsyncValue<GroupTripListItem?>>((ref) {
  final async = ref.watch(myGroupTripsStreamProvider);
  return async.when(
    data: (items) => AsyncData(_pickDashboardTrip(items)),
    loading: () => const AsyncLoading(),
    error: (e, st) => AsyncError(e, st),
  );
});

GroupTripListItem? _pickDashboardTrip(List<GroupTripListItem> items) {
  if (items.isEmpty) return null;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final candidates = items.where((item) {
    final end = item.trip.endDate;
    final endDay = DateTime(end.year, end.month, end.day);
    return !endDay.isBefore(today);
  }).toList();
  if (candidates.isEmpty) return null;
  candidates.sort((a, b) => a.trip.startDate.compareTo(b.trip.startDate));
  return candidates.first;
}
