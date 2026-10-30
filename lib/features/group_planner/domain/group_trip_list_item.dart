import 'group_trip.dart';

/// One row in "Your trips" with permission flags from Firestore membership.
class GroupTripListItem {
  const GroupTripListItem({
    required this.trip,
    required this.canEditTripSettings,
    required this.canDeleteTrip,
  });

  final GroupTrip trip;

  /// Owner or trip admin — may edit trip metadata or delete the trip.
  final bool canEditTripSettings;

  final bool canDeleteTrip;
}
