import 'package:cloud_firestore/cloud_firestore.dart';

import 'trip_budget_type.dart';

class GroupTrip {
  const GroupTrip({
    required this.id,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.groupSize,
    required this.budgetType,
    required this.budgetAmount,
    required this.ownerId,
    this.inviteCode,
  });

  final String id;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final int groupSize;
  final TripBudgetType budgetType;
  final double budgetAmount;
  final String ownerId;

  /// Short alphanumeric invite key mapped in [GroupTripPaths.inviteCodesCollection].
  final String? inviteCode;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'destination': destination,
      'startDate': Timestamp.fromDate(startDate.toUtc()),
      'endDate': Timestamp.fromDate(endDate.toUtc()),
      'groupSize': groupSize,
      'budgetType': budgetType.wireValue,
      'budgetAmount': budgetAmount,
      'ownerId': ownerId,
      if (inviteCode != null && inviteCode!.isNotEmpty) 'inviteCode': inviteCode,
    };
  }

  factory GroupTrip.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String? ?? '';
    final destination = json['destination'] as String? ?? '';
    final ownerId = json['ownerId'] as String? ?? '';

    final start = _readDate(json['startDate']);
    final end = _readDate(json['endDate']);
    final now = DateTime.now();

    return GroupTrip(
      id: id,
      destination: destination,
      startDate: start ?? now,
      endDate: end ?? now,
      groupSize: (json['groupSize'] as num?)?.toInt() ?? 1,
      budgetType: TripBudgetType.fromWire(json['budgetType'] as String?),
      budgetAmount: (json['budgetAmount'] as num?)?.toDouble() ?? 0,
      ownerId: ownerId,
      inviteCode: json['inviteCode'] as String?,
    );
  }

  static DateTime? _readDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
