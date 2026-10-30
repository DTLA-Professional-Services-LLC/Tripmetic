import 'trip_member_role.dart';

class TripMember {
  const TripMember({
    required this.userId,
    required this.email,
    required this.role,
    required this.colorCode,
  });

  final String userId;
  final String email;
  final TripMemberRole role;
  /// Hex color e.g. `#FF5722` to attribute planned items.
  final String colorCode;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'role': role.wireValue,
      'colorCode': colorCode,
    };
  }

  factory TripMember.fromJson(Map<String, dynamic> json) {
    return TripMember(
      userId: json['userId'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: TripMemberRole.fromWire(json['role'] as String?),
      colorCode: json['colorCode'] as String? ?? '#000000',
    );
  }
}
