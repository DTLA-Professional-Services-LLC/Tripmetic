/// Fixed packing list groupings (Hive / UI).
abstract final class PackingCategory {
  static const documents = 'Documents';
  static const reservations = 'Reservations';
  static const clothing = 'Clothing';
  static const medications = 'Medications';
  static const misc = 'Misc';

  static const List<String> all = [
    documents,
    reservations,
    clothing,
    medications,
    misc,
  ];

  static bool isValid(String c) => all.contains(c);
}
