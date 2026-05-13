import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../domain/group_trip.dart';
import '../domain/trip_activity.dart';
import '../domain/trip_budget_type.dart';
import '../domain/trip_member.dart';
import '../domain/trip_member_role.dart';
import '../data/group_trip_paths.dart';

/// Thrown when an operation violates group planner rules (e.g. permissions).
@immutable
class GroupPlannerException implements Exception {
  const GroupPlannerException(this.message);

  final String message;

  @override
  String toString() => 'GroupPlannerException: $message';
}

/// Firestore-backed operations for real-time group trips.
class GroupTripService {
  GroupTripService({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    Uuid? uuid,
  })  : _db = firestore,
        _auth = auth,
        _uuid = uuid ?? const Uuid();

  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  final Uuid _uuid;

  DocumentReference<Map<String, dynamic>> _tripRef(String tripId) =>
      _db.collection(GroupTripPaths.collection).doc(tripId);

  CollectionReference<Map<String, dynamic>> _membersCol(String tripId) =>
      _tripRef(tripId).collection(GroupTripPaths.membersSubcollection);

  CollectionReference<Map<String, dynamic>> _activitiesCol(String tripId) =>
      _tripRef(tripId).collection(GroupTripPaths.activitiesSubcollection);

  DocumentReference<Map<String, dynamic>> _inviteRef(String code) =>
      _db.collection(GroupTripPaths.inviteCodesCollection).doc(code);

  static final RegExp _uuidV4Like = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  static const String _inviteCharset = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  String _randomInviteCode() {
    final rnd = Random.secure();
    final len = 6 + rnd.nextInt(3);
    final buf = StringBuffer();
    for (var i = 0; i < len; i++) {
      buf.write(_inviteCharset[rnd.nextInt(_inviteCharset.length)]);
    }
    return buf.toString();
  }

  Future<String> _allocateUniqueInviteCode() async {
    for (var attempt = 0; attempt < 48; attempt++) {
      final code = _randomInviteCode();
      final snap = await _inviteRef(code).get();
      if (!snap.exists) return code;
    }
    throw GroupPlannerException('Could not allocate a trip invite code.');
  }

  /// Maps a route parameter (UUID or short code) to the canonical Firestore trip id.
  Future<String> resolveTripKey(String raw) async {
    final t = raw.trim();
    if (t.isEmpty) {
      throw GroupPlannerException('Enter a trip code or link.');
    }
    if (_uuidV4Like.hasMatch(t)) {
      return t.toLowerCase();
    }
    final compact = t.replaceAll(RegExp(r'\s+'), '');
    final alnum = compact.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    if (alnum.length >= 6 &&
        alnum.length <= 8 &&
        RegExp(r'^[A-Za-z0-9]+$').hasMatch(alnum)) {
      final invite = await _inviteRef(alnum.toUpperCase()).get();
      if (invite.exists) {
        final id = invite.data()?['tripId'] as String?;
        if (id != null && id.isNotEmpty) return id;
      }
    }
    final direct = await _tripRef(compact).get();
    if (direct.exists) return compact;

    throw GroupPlannerException('Unknown trip code.');
  }

  /// Ensures [GroupTrip.inviteCode] and [GroupTripPaths.inviteCodesCollection] exist.
  Future<String> ensureInviteCodeForTrip(String tripId) async {
    final snap = await _tripRef(tripId).get();
    if (!snap.exists) {
      throw GroupPlannerException('Trip not found.');
    }
    final existing = snap.data()?['inviteCode'] as String?;
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    for (var attempt = 0; attempt < 48; attempt++) {
      final code = _randomInviteCode();
      final taken = await _inviteRef(code).get();
      if (taken.exists) continue;

      final batch = _db.batch();
      batch.update(_tripRef(tripId), <String, dynamic>{'inviteCode': code});
      batch.set(_inviteRef(code), <String, dynamic>{
        'tripId': tripId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      try {
        await batch.commit();
        return code;
      } catch (_) {
        continue;
      }
    }
    throw GroupPlannerException('Could not allocate a trip invite code.');
  }

  User _requireUser() {
    final u = _auth.currentUser;
    if (u == null) {
      throw GroupPlannerException('You must be signed in.');
    }
    return u;
  }

  /// Creates a new trip document and adds the current user as [TripMemberRole.admin].
  ///
  /// Also registers a short invite code for links and the join-by-code flow.
  Future<({String tripId, String inviteCode})> createTrip({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int groupSize,
    required TripBudgetType budgetType,
    required double budgetAmount,
    String ownerColorCode = '#1976D2',
  }) async {
    final user = _requireUser();
    final email = user.email ?? '';
    final tripId = _uuid.v4();
    final inviteCode = await _allocateUniqueInviteCode();

    final trip = GroupTrip(
      id: tripId,
      destination: destination.trim(),
      startDate: startDate,
      endDate: endDate,
      groupSize: groupSize.clamp(1, 10000),
      budgetType: budgetType,
      budgetAmount: budgetAmount.isFinite ? budgetAmount : 0,
      ownerId: user.uid,
      inviteCode: inviteCode,
    );

    final ownerMember = TripMember(
      userId: user.uid,
      email: email,
      role: TripMemberRole.admin,
      colorCode: ownerColorCode,
    );

    final batch = _db.batch();
    batch.set(_tripRef(tripId), trip.toJson());
    batch.set(_membersCol(tripId).doc(user.uid), ownerMember.toJson());
    batch.set(_inviteRef(inviteCode), <String, dynamic>{
      'tripId': tripId,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await batch.commit();
    return (tripId: tripId, inviteCode: inviteCode);
  }

  /// Share text suitable for email/messages with deep link and trip code.
  Future<void> shareEmailInvitation({
    required String tripId,
    String? destinationLabel,
  }) async {
    final code = await ensureInviteCodeForTrip(tripId);
    final httpsLink = GroupTripPaths.httpsDeepLink(code);
    final deepLink = GroupTripPaths.customSchemeDeepLink(code);
    final androidIntent = GroupTripPaths.androidInviteIntentUrl(code);
    final header = destinationLabel != null && destinationLabel.trim().isNotEmpty
        ? 'Join my trip to ${destinationLabel.trim()} on Tripmetic!'
        : 'Join my trip on Tripmetic!';
    final text = '''
$header

Open in Tripmetic (web / App Link):
$httpsLink

Open in Tripmetic (direct — iOS/Android):
$deepLink

Android — tap to open app or Play Store if missing:
$androidIntent

Trip code: $code

Get Tripmetic — iOS: ${GroupTripPaths.iosAppStoreUrl}
Get Tripmetic — Android: ${GroupTripPaths.androidPlayStoreUrl}''';
    final subject = destinationLabel != null && destinationLabel.trim().isNotEmpty
        ? 'Tripmetic — ${destinationLabel.trim()}'
        : 'Tripmetic — join my trip';
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: subject,
      ),
    );
  }

  Future<TripMember?> _member(String tripId, String userId) async {
    final snap = await _membersCol(tripId).doc(userId).get();
    if (!snap.exists || snap.data() == null) return null;
    final data = Map<String, dynamic>.from(snap.data()!);
    data['userId'] = snap.id;
    return TripMember.fromJson(data);
  }

  Future<void> _assertCanManageMembers(String tripId) async {
    await _assertTripOwnerOrAdmin(tripId);
  }

  Future<void> _assertTripOwnerOrAdmin(String tripId) async {
    final user = _requireUser();
    final tripSnap = await _tripRef(tripId).get();
    if (!tripSnap.exists) {
      throw GroupPlannerException('Trip not found.');
    }
    final ownerId = tripSnap.data()?['ownerId'] as String?;
    if (ownerId == user.uid) return;

    final member = await _member(tripId, user.uid);
    if (member?.role == TripMemberRole.admin) return;

    throw GroupPlannerException(
      'Only the trip owner or a trip admin can do that.',
    );
  }

  Future<void> _deleteCollectionDocs(
    CollectionReference<Map<String, dynamic>> col,
  ) async {
    while (true) {
      final snap = await col.limit(400).get();
      if (snap.docs.isEmpty) break;
      final batch = _db.batch();
      for (final d in snap.docs) {
        batch.delete(d.reference);
      }
      await batch.commit();
    }
  }

  /// Deletes the trip, all members, activities, and its invite-code mapping.
  Future<void> deleteTrip(String tripId) async {
    await _assertTripOwnerOrAdmin(tripId);
    final tripSnap = await _tripRef(tripId).get();
    if (!tripSnap.exists) return;
    final inviteRaw = tripSnap.data()?['inviteCode'] as String?;
    final inviteCode = inviteRaw?.trim();

    // Remove invite mapping before members (rules may require admin membership).
    if (inviteCode != null && inviteCode.isNotEmpty) {
      await _inviteRef(inviteCode.toUpperCase()).delete();
    }

    await _deleteCollectionDocs(_activitiesCol(tripId));
    await _deleteCollectionDocs(_membersCol(tripId));
    await _tripRef(tripId).delete();
  }

  /// Updates trip metadata (owner or trip admin only).
  Future<void> updateTrip({
    required String tripId,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int groupSize,
    required TripBudgetType budgetType,
    required double budgetAmount,
  }) async {
    await _assertTripOwnerOrAdmin(tripId);
    await _tripRef(tripId).update(<String, dynamic>{
      'destination': destination.trim(),
      'startDate': Timestamp.fromDate(startDate.toUtc()),
      'endDate': Timestamp.fromDate(endDate.toUtc()),
      'groupSize': groupSize.clamp(1, 10000),
      'budgetType': budgetType.wireValue,
      'budgetAmount': budgetAmount.isFinite ? budgetAmount : 0,
    });
  }

  Future<void> addMember({
    required String tripId,
    required String userId,
    required String email,
    required TripMemberRole role,
    required String colorCode,
  }) async {
    await _assertCanManageMembers(tripId);
    final member = TripMember(
      userId: userId,
      email: email.trim(),
      role: role,
      colorCode: colorCode,
    );
    await _membersCol(tripId).doc(userId).set(member.toJson());
  }

  Future<void> removeMember({
    required String tripId,
    required String userId,
  }) async {
    await _assertCanManageMembers(tripId);
    final tripSnap = await _tripRef(tripId).get();
    final ownerId = tripSnap.data()?['ownerId'] as String?;
    if (userId == ownerId) {
      throw GroupPlannerException('Cannot remove the trip owner.');
    }
    await _membersCol(tripId).doc(userId).delete();
  }

  Future<void> updateMemberRole({
    required String tripId,
    required String userId,
    required TripMemberRole newRole,
  }) async {
    await _assertCanManageMembers(tripId);
    final tripSnap = await _tripRef(tripId).get();
    final ownerId = tripSnap.data()?['ownerId'] as String?;
    if (userId == ownerId && newRole != TripMemberRole.admin) {
      throw GroupPlannerException('The owner must remain an admin.');
    }
    await _membersCol(tripId).doc(userId).update(<String, dynamic>{
      'role': newRole.wireValue,
    });
  }

  Future<void> addActivity({
    required String tripId,
    required String title,
    String notes = '',
    String? link,
  }) async {
    final user = _requireUser();
    final member = await _member(tripId, user.uid);
    if (member == null) {
      throw GroupPlannerException('You are not a member of this trip.');
    }
    if (!member.role.canPlanActivities) {
      throw GroupPlannerException('View-only members cannot add activities.');
    }

    final activityId = _uuid.v4();
    final activity = TripActivity(
      id: activityId,
      title: title.trim(),
      notes: notes.trim(),
      link: link?.trim().isNotEmpty == true ? link!.trim() : null,
      plannedByUserId: user.uid,
      votes: const <String, int>{},
    );

    await _activitiesCol(tripId).doc(activityId).set(activity.toJson());
  }

  /// Sets the current user's vote to `1` or `-1`. Same value again keeps the vote.
  Future<void> castVoteOnActivity({
    required String tripId,
    required String activityId,
    required int value,
  }) async {
    if (value != 1 && value != -1) {
      throw GroupPlannerException('Vote must be 1 or -1.');
    }
    final user = _requireUser();
    final member = await _member(tripId, user.uid);
    if (member == null) {
      throw GroupPlannerException('You are not a member of this trip.');
    }

    await _activitiesCol(tripId).doc(activityId).update(<String, dynamic>{
      'votes.${user.uid}': value,
    });
  }

  Future<void> updateActivity({
    required String tripId,
    required String activityId,
    required String title,
    String notes = '',
    String? link,
  }) async {
    final user = _requireUser();
    final member = await _member(tripId, user.uid);
    if (member == null) {
      throw GroupPlannerException('You are not a member of this trip.');
    }
    if (!member.role.canPlanActivities) {
      throw GroupPlannerException('View-only members cannot edit activities.');
    }

    final payload = <String, dynamic>{
      'title': title.trim(),
      'notes': notes.trim(),
    };
    if (link == null || link.trim().isEmpty) {
      payload['link'] = FieldValue.delete();
    } else {
      payload['link'] = link.trim();
    }
    await _activitiesCol(tripId).doc(activityId).update(payload);
  }

  Future<void> deleteActivity({
    required String tripId,
    required String activityId,
  }) async {
    final user = _requireUser();
    final member = await _member(tripId, user.uid);
    if (member == null) {
      throw GroupPlannerException('You are not a member of this trip.');
    }
    if (!member.role.canPlanActivities) {
      throw GroupPlannerException('View-only members cannot delete activities.');
    }
    await _activitiesCol(tripId).doc(activityId).delete();
  }
}
