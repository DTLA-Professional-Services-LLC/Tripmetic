/// One scheduled item on the travel itinerary.
class ItineraryEvent {
  const ItineraryEvent({
    required this.id,
    required this.startDateTime,
    required this.title,
    required this.location,
    required this.notes,
    this.latitude,
    this.longitude,
  });

  final String id;
  final DateTime startDateTime;
  final String title;
  final String location;
  final String notes;

  /// Set when the event was added from the map (or edited with coordinates).
  final double? latitude;
  final double? longitude;

  ItineraryEvent copyWith({
    String? id,
    DateTime? startDateTime,
    String? title,
    String? location,
    String? notes,
    double? latitude,
    double? longitude,
  }) {
    return ItineraryEvent(
      id: id ?? this.id,
      startDateTime: startDateTime ?? this.startDateTime,
      title: title ?? this.title,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'startMs': startDateTime.millisecondsSinceEpoch,
        'title': title,
        'location': location,
        'notes': notes,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
      };

  static int? _parseStartMs(Object? raw) {
    if (raw == null) return null;
    if (raw is int) return raw;
    if (raw is num) return raw.round();
    if (raw is String) return int.tryParse(raw);
    return null;
  }

  static double? _parseDouble(Object? raw) {
    if (raw == null) return null;
    if (raw is double) return raw;
    if (raw is int) return raw.toDouble();
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw);
    return null;
  }

  /// Safe strings for UI when data is empty or from partial JSON.
  String get displayTitle =>
      title.trim().isEmpty ? 'Untitled event' : title.trim();

  String get displayLocation => location.trim();

  String get displayNotes => notes.trim();

  static ItineraryEvent? fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return null;
    final rawId = json['id'];
    final id = rawId == null ? '' : rawId.toString().trim();
    final ms = _parseStartMs(json['startMs']);
    if (ms == null) return null;

    DateTime start;
    try {
      start = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: false);
    } catch (_) {
      return null;
    }

    final safeId = id.isEmpty ? 'legacy_${ms.toString()}' : id;

    String field(dynamic v) {
      if (v == null) return '';
      final s = v.toString();
      return s.trim();
    }

    return ItineraryEvent(
      id: safeId,
      startDateTime: start,
      title: field(json['title']),
      location: field(json['location']),
      notes: field(json['notes']),
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
    );
  }
}
