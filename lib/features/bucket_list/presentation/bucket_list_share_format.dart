import '../domain/travel_destination.dart';

/// Builds a plain-text summary grouped by category (Tripmetic bucket list share body).
String buildBucketListShareText({
  required List<TravelDestination> destinations,
  required String Function(TravelDestinationCategory c) categoryTitle,
}) {
  final buf = StringBuffer('Tripmetic — Bucket list\n\n');

  for (final cat in TravelDestinationCategory.values) {
    final rows =
        destinations.where((d) => d.category == cat).toList(growable: false);
    if (rows.isEmpty) continue;

    buf.writeln('${categoryTitle(cat)}:');
    for (final d in rows) {
      buf.write('- ');
      buf.write(d.displayName);
      if (d.isUpcoming && d.startDate != null && d.endDate != null) {
        buf.write(
          ' (${d.startDate!.toIso8601String().split('T').first} → '
          '${d.endDate!.toIso8601String().split('T').first})',
        );
      }
      buf.writeln();
    }
    buf.writeln();
  }

  return buf.toString().trimRight();
}
