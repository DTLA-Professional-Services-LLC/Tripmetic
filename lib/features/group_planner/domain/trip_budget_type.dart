/// Stored in Firestore as [wireValue].
enum TripBudgetType {
  perPerson('per_person'),
  group('group'),
  none('none');

  const TripBudgetType(this.wireValue);

  final String wireValue;

  static TripBudgetType fromWire(String? raw) {
    switch (raw) {
      case 'per_person':
        return TripBudgetType.perPerson;
      case 'group':
        return TripBudgetType.group;
      case 'none':
      default:
        return TripBudgetType.none;
    }
  }
}
