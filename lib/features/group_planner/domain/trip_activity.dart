import 'package:cloud_firestore/cloud_firestore.dart';

class TripActivity {
  const TripActivity({
    required this.id,
    required this.title,
    required this.notes,
    required this.link,
    required this.plannedByUserId,
    required this.votes,
    this.scheduledAt,
  });

  final String id;
  final String title;
  final String notes;
  final String? link;
  final String plannedByUserId;
  /// Firestore map: userId -> `1` (up) or `-1` (down).
  final Map<String, int> votes;

  /// When the activity happens. Null for legacy activities without this field.
  final DateTime? scheduledAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'notes': notes,
      if (link != null && link!.trim().isNotEmpty) 'link': link,
      'plannedByUserId': plannedByUserId,
      'votes': votes,
      if (scheduledAt != null)
        'scheduledAt': Timestamp.fromDate(scheduledAt!.toUtc()),
    };
  }

  factory TripActivity.fromJson(Map<String, dynamic> json) {
    final votesRaw = json['votes'];
    final votes = <String, int>{};
    if (votesRaw is Map) {
      for (final e in votesRaw.entries) {
        final k = e.key?.toString();
        final v = e.value;
        if (k == null || k.isEmpty) continue;
        if (v is num) {
          final n = v.toInt();
          if (n == 1 || n == -1) votes[k] = n;
        }
      }
    }

    return TripActivity(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      link: json['link'] as String?,
      plannedByUserId: json['plannedByUserId'] as String? ?? '',
      votes: votes,
      scheduledAt: _readScheduled(json['scheduledAt']),
    );
  }

  static DateTime? _readScheduled(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
