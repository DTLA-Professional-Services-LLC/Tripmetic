import 'travel_destination.dart';

/// Merges local and remote lists by [TravelDestination.id] using
/// [TravelDestination.lastModifiedMs] (null → 0) for last-write-wins.
List<TravelDestination> mergeBucketListById(
  List<TravelDestination> local,
  List<TravelDestination> remote,
) {
  final byId = <String, TravelDestination>{};

  for (final d in local) {
    byId[d.id] = d;
  }
  for (final d in remote) {
    final existing = byId[d.id];
    if (existing == null) {
      byId[d.id] = d;
    } else {
      byId[d.id] = _newerOf(existing, d);
    }
  }

  final merged = byId.values.toList(growable: false);
  merged.sort((a, b) => a.displayName.compareTo(b.displayName));
  return merged;
}

TravelDestination _newerOf(TravelDestination a, TravelDestination b) {
  final ta = a.lastModifiedMs ?? 0;
  final tb = b.lastModifiedMs ?? 0;
  return ta >= tb ? a : b;
}
