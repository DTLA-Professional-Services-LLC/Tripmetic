/// Bucket-list categories for places the user has visited, wants to visit,
/// lives in, lived in, or plans to visit.
enum TravelDestinationCategory {
  been,
  want,
  live,
  lived,
  upcoming,
}

/// A saved travel destination with optional trip dates for [upcoming] entries.
class TravelDestination {
  TravelDestination({
    required this.id,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.category,
    this.state,
    this.startDate,
    this.endDate,
    this.lastModifiedMs,
  }) : assert(
          category != TravelDestinationCategory.upcoming ||
              (startDate != null && endDate != null),
          'Upcoming destinations require startDate and endDate',
        );

  final String id;
  final String city;
  final String country;

  /// State / province — improves US state metrics when [country] is the United States.
  /// Persisted as `state`; legacy Hive/Firestore may still use `region`.
  final String? state;

  final double latitude;
  final double longitude;
  final TravelDestinationCategory category;

  /// Required when [category] is [TravelDestinationCategory.upcoming].
  final DateTime? startDate;
  final DateTime? endDate;

  /// Client / merge timestamp (ms since epoch). Null treated as 0 in merges.
  final int? lastModifiedMs;

  bool get isUpcoming => category == TravelDestinationCategory.upcoming;

  String get displayName {
    final r = state?.trim();
    if (r != null && r.isNotEmpty) {
      return '$city, $r, $country';
    }
    return '$city, $country';
  }

  TravelDestination copyWith({
    String? id,
    String? city,
    String? country,
    String? state,
    double? latitude,
    double? longitude,
    TravelDestinationCategory? category,
    DateTime? startDate,
    DateTime? endDate,
    int? lastModifiedMs,
    bool clearState = false,
    bool clearDates = false,
    bool clearLastModified = false,
  }) {
    return TravelDestination(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      state: clearState ? null : (state ?? this.state),
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      startDate: clearDates ? null : (startDate ?? this.startDate),
      endDate: clearDates ? null : (endDate ?? this.endDate),
      lastModifiedMs: clearLastModified
          ? null
          : (lastModifiedMs ?? this.lastModifiedMs),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'category': category.name,
      if (state != null && state!.trim().isNotEmpty) ...<String, dynamic>{
        'state': state,
        'region': state,
      },
      if (startDate != null) 'startDate': startDate!.toUtc().toIso8601String(),
      if (endDate != null) 'endDate': endDate!.toUtc().toIso8601String(),
      if (lastModifiedMs != null) 'lastModifiedMs': lastModifiedMs,
    };
  }

  static TravelDestination? fromJson(Map<String, dynamic> m) {
    try {
      final id = m['id'] as String?;
      final city = m['city'] as String?;
      final country = m['country'] as String?;
      if (id == null ||
          city == null ||
          country == null ||
          id.isEmpty ||
          city.trim().isEmpty ||
          country.trim().isEmpty) {
        return null;
      }
      final lat = _jsonDouble(m['latitude']);
      final lng = _jsonDouble(m['longitude']);
      if (lat == null || lng == null) return null;

      final catName = m['category'] as String?;
      TravelDestinationCategory category;
      if (catName != null) {
        try {
          category = TravelDestinationCategory.values.byName(catName);
        } catch (_) {
          category = TravelDestinationCategory.want;
        }
      } else {
        category = TravelDestinationCategory.want;
      }

      DateTime? sd;
      DateTime? ed;
      final sds = m['startDate'];
      final eds = m['endDate'];
      if (sds is String) sd = DateTime.tryParse(sds)?.toUtc();
      if (eds is String) ed = DateTime.tryParse(eds)?.toUtc();

      final stateRaw = (m['state'] ?? m['region']) as String?;
      final stateTrim = stateRaw?.trim();
      final state =
          stateTrim == null || stateTrim.isEmpty ? null : stateTrim;

      final lm = m['lastModifiedMs'];
      final lastModifiedMs = lm is num ? lm.toInt() : null;

      return TravelDestination(
        id: id,
        city: city.trim(),
        country: country.trim(),
        state: state,
        latitude: lat,
        longitude: lng,
        category: category,
        startDate: sd,
        endDate: ed,
        lastModifiedMs: lastModifiedMs,
      );
    } catch (_) {
      return null;
    }
  }

  static double? _jsonDouble(Object? v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  /// Mock seed data for UI development (coordinates approximate city centers).
  static List<TravelDestination> get seedList => _seedList;

  static final List<TravelDestination> _seedList =
      List<TravelDestination>.unmodifiable(<TravelDestination>[
        TravelDestination(
          id: 'seed_hcmc',
          city: 'Ho Chi Minh City',
          country: 'Vietnam',
          latitude: 10.8231,
          longitude: 106.6297,
          category: TravelDestinationCategory.been,
        ),
        TravelDestination(
          id: 'seed_vancouver',
          city: 'Vancouver',
          country: 'Canada',
          latitude: 49.2827,
          longitude: -123.1207,
          category: TravelDestinationCategory.been,
        ),
        TravelDestination(
          id: 'seed_vegas',
          city: 'Las Vegas',
          country: 'United States',
          state: 'Nevada',
          latitude: 36.1699,
          longitude: -115.1398,
          category: TravelDestinationCategory.been,
        ),
        TravelDestination(
          id: 'seed_tokyo',
          city: 'Tokyo',
          country: 'Japan',
          latitude: 35.6762,
          longitude: 139.6503,
          category: TravelDestinationCategory.want,
        ),
        TravelDestination(
          id: 'seed_la',
          city: 'Los Angeles',
          country: 'United States',
          state: 'California',
          latitude: 34.0522,
          longitude: -118.2437,
          category: TravelDestinationCategory.live,
        ),
        TravelDestination(
          id: 'seed_sandiego',
          city: 'San Diego',
          country: 'United States',
          state: 'California',
          latitude: 32.7157,
          longitude: -117.1611,
          category: TravelDestinationCategory.lived,
        ),
        TravelDestination(
          id: 'seed_rome',
          city: 'Rome',
          country: 'Italy',
          latitude: 41.9028,
          longitude: 12.4964,
          category: TravelDestinationCategory.upcoming,
          startDate: DateTime.utc(2026, 10, 10),
          endDate: DateTime.utc(2026, 10, 24),
        ),
      ]);
}
