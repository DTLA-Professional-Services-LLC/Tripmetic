import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/travel_destination.dart';

/// Maps [TravelDestination] to/from Firestore documents under
/// `users/{userId}/bucket_list/{destinationId}`.
abstract final class BucketListFirestoreMapper {
  static Map<String, dynamic> toMap(TravelDestination d) {
    return <String, dynamic>{
      'city': d.city,
      'country': d.country,
      'latitude': d.latitude,
      'longitude': d.longitude,
      'category': d.category.name,
      if (d.state != null && d.state!.trim().isNotEmpty) ...<String, dynamic>{
        'state': d.state,
        'region': d.state,
      },
      if (d.startDate != null)
        'startDate': Timestamp.fromDate(d.startDate!.toUtc()),
      if (d.endDate != null) 'endDate': Timestamp.fromDate(d.endDate!.toUtc()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static TravelDestination? fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snap,
  ) {
    if (!snap.exists) return null;
    final m = snap.data();
    if (m == null) return null;

    final city = m['city'] as String?;
    final country = m['country'] as String?;
    if (city == null ||
        city.trim().isEmpty ||
        country == null ||
        country.trim().isEmpty) {
      return null;
    }

    final lat = _toDouble(m['latitude']);
    final lng = _toDouble(m['longitude']);
    if (lat == null || lng == null) return null;

    final stateRaw = (m['state'] ?? m['region']) as String?;
    final stateTrimmed = stateRaw?.trim();
    final state =
        stateTrimmed == null || stateTrimmed.isEmpty ? null : stateTrimmed;
    final cat = _parseCategory(m['category']);

    DateTime? start;
    DateTime? end;
    final sd = m['startDate'];
    final ed = m['endDate'];
    if (sd is Timestamp) start = sd.toDate();
    if (ed is Timestamp) end = ed.toDate();

    if (cat == TravelDestinationCategory.upcoming &&
        (start == null || end == null)) {
      return null;
    }

    try {
      final updatedMs = _timestampMs(m['updatedAt']);
      return TravelDestination(
        id: snap.id,
        city: city.trim(),
        country: country.trim(),
        state: state,
        latitude: lat,
        longitude: lng,
        category: cat,
        startDate: start,
        endDate: end,
        lastModifiedMs: updatedMs,
      );
    } catch (_) {
      return null;
    }
  }

  static TravelDestinationCategory _parseCategory(Object? raw) {
    if (raw is! String) return TravelDestinationCategory.want;
    try {
      return TravelDestinationCategory.values.byName(raw);
    } catch (_) {
      return TravelDestinationCategory.want;
    }
  }

  static double? _toDouble(Object? v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  static int? _timestampMs(Object? v) {
    if (v is Timestamp) return v.millisecondsSinceEpoch;
    return null;
  }
}
