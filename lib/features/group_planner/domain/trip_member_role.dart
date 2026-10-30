/// Stored in Firestore as [wireValue].
enum TripMemberRole {
  admin('admin'),
  coPlanner('co-planner'),
  viewOnly('view-only');

  const TripMemberRole(this.wireValue);

  final String wireValue;

  static TripMemberRole fromWire(String? raw) {
    switch (raw) {
      case 'admin':
        return TripMemberRole.admin;
      case 'co-planner':
        return TripMemberRole.coPlanner;
      case 'view-only':
        return TripMemberRole.viewOnly;
      default:
        return TripMemberRole.viewOnly;
    }
  }

  /// Trip admins and trip coordinators may edit the itinerary; view-only
  /// members can vote but not add, edit, or delete activities.
  bool get canPlanActivities =>
      this == TripMemberRole.admin || this == TripMemberRole.coPlanner;
}
