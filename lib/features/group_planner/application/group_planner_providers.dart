import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bucket_list/application/bucket_list_auth_providers.dart';
import '../domain/group_trip.dart';
import '../domain/group_trip_list_item.dart';
import '../domain/trip_activity.dart';
import '../domain/trip_member.dart';
import '../domain/trip_member_role.dart';
import '../data/group_trip_paths.dart';
import 'group_trip_service.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final groupTripServiceProvider = Provider<GroupTripService>(
  (ref) => GroupTripService(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: FirebaseAuth.instance,
  ),
);

/// Resolves `/group-trip/:param` (UUID, short code, or pasted URL fragment) to a trip id.
final resolvedGroupTripIdProvider = FutureProvider.family<String, String>(
  (ref, rawRouteParam) async {
    final extracted = GroupTripPaths.extractTripRefFromUserInput(
      Uri.decodeComponent(rawRouteParam),
    );
    return ref.read(groupTripServiceProvider).resolveTripKey(extracted);
  },
);

/// Trips the user owns (`ownerId`) plus trips where they appear in `members`,
/// with [GroupTripListItem.canDeleteTrip] / [GroupTripListItem.canEditTripSettings] for owner or trip admin.
final myGroupTripsStreamProvider = StreamProvider<List<GroupTripListItem>>((ref) {
  return ref.watch(firebaseAuthUserProvider).when(
        data: (user) {
          final uid = user?.uid;
          final db = ref.watch(firebaseFirestoreProvider);
          if (uid == null) {
            return Stream.value(<GroupTripListItem>[]);
          }

          final controller = StreamController<List<GroupTripListItem>>();
          final ownerTrips = <String, GroupTrip>{};
          final memberTrips = <String, GroupTrip>{};
          final memberAdminCaps = <String, bool>{};
          var memberReloadGen = 0;

          void emitMerged() {
            final ids = <String>{...ownerTrips.keys, ...memberTrips.keys};
            final list = <GroupTripListItem>[];
            for (final id in ids) {
              final trip = ownerTrips[id] ?? memberTrips[id]!;
              final fromOwnerQuery = ownerTrips.containsKey(id);
              final adminCap = memberAdminCaps[id] ?? false;
              final canManageTrip = fromOwnerQuery || adminCap;
              list.add(
                GroupTripListItem(
                  trip: trip,
                  canEditTripSettings: canManageTrip,
                  canDeleteTrip: canManageTrip,
                ),
              );
            }
            list.sort(
              (a, b) => a.trip.startDate.compareTo(b.trip.startDate),
            );
            if (!controller.isClosed) {
              controller.add(list);
            }
          }

          final subOwner = db
              .collection(GroupTripPaths.collection)
              .where('ownerId', isEqualTo: uid)
              .snapshots()
              .listen(
            (snap) {
              ownerTrips.clear();
              for (final d in snap.docs) {
                final data = Map<String, dynamic>.from(d.data());
                data['id'] = d.id;
                ownerTrips[d.id] = GroupTrip.fromJson(data);
              }
              memberTrips.removeWhere(
                (id, trip) => trip.ownerId == uid && !ownerTrips.containsKey(id),
              );
              memberAdminCaps.removeWhere(
                (id, _) => !memberTrips.containsKey(id),
              );
              emitMerged();
            },
            onError: (Object e, StackTrace st) {
              if (!controller.isClosed) {
                controller.addError(e, st);
              }
            },
          );

          final subMember = db
              .collectionGroup(GroupTripPaths.membersSubcollection)
              .where('userId', isEqualTo: uid)
              .snapshots()
              .listen(
            (snap) {
              final gen = ++memberReloadGen;
              unawaited(() async {
                try {
                  final nextTrips = <String, GroupTrip>{};
                  final nextCaps = <String, bool>{};
                  for (final d in snap.docs) {
                    if (gen != memberReloadGen) return;
                    final tripRef = d.reference.parent.parent;
                    if (tripRef == null) continue;
                    final tripDoc = await tripRef.get();
                    if (gen != memberReloadGen) return;
                    if (!tripDoc.exists || tripDoc.data() == null) continue;
                    final data = Map<String, dynamic>.from(tripDoc.data()!);
                    data['id'] = tripDoc.id;
                    final trip = GroupTrip.fromJson(data);
                    final role = TripMemberRole.fromWire(
                      d.data()['role'] as String?,
                    );
                    final canAdministrate =
                        trip.ownerId == uid || role == TripMemberRole.admin;
                    nextTrips[tripDoc.id] = trip;
                    nextCaps[tripDoc.id] = canAdministrate;
                  }
                  if (gen != memberReloadGen) return;
                  memberTrips
                    ..clear()
                    ..addAll(nextTrips);
                  memberAdminCaps
                    ..clear()
                    ..addAll(nextCaps);
                  emitMerged();
                } catch (e, st) {
                  debugPrint('group trips member-lookup error: $e\n$st');
                  // Keep the dashboard working with owner-only results.
                  memberTrips.clear();
                  memberAdminCaps.clear();
                  emitMerged();
                }
              }());
            },
            onError: (Object e, StackTrace st) {
              // The `collectionGroup('members').where('userId', ...)` query
              // requires a composite COLLECTION_GROUP_ASC index. When that
              // index is missing Firestore throws `failed-precondition`; fall
              // back to owner-only results instead of surfacing a raw error
              // to UI listeners (see dashboard `Active trip snapshot` card).
              debugPrint('group trips snapshot error: $e\n$st');
              memberTrips.clear();
              memberAdminCaps.clear();
              emitMerged();
            },
          );

          ref.onDispose(() async {
            await subOwner.cancel();
            await subMember.cancel();
            await controller.close();
          });

          emitMerged();

          return controller.stream;
        },
        loading: () => Stream.value(<GroupTripListItem>[]),
        error: (_, _) => Stream.value(<GroupTripListItem>[]),
      );
});

/// Real-time [GroupTrip] document at `group_trips/{tripId}`.
final groupTripStreamProvider = StreamProvider.family<GroupTrip?, String>(
  (ref, tripId) {
    final db = ref.watch(firebaseFirestoreProvider);
    return db
        .collection(GroupTripPaths.collection)
        .doc(tripId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snap) {
      if (!snap.exists || snap.data() == null) return null;
      final data = Map<String, dynamic>.from(snap.data()!);
      data['id'] = snap.id;
      return GroupTrip.fromJson(data);
    });
  },
);

/// Real-time members under `group_trips/{tripId}/members`.
final groupTripMembersStreamProvider =
    StreamProvider.family<List<TripMember>, String>(
  (ref, tripId) {
    final db = ref.watch(firebaseFirestoreProvider);
    return db
        .collection(GroupTripPaths.collection)
        .doc(tripId)
        .collection(GroupTripPaths.membersSubcollection)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snap) {
      final list = snap.docs.map((d) {
        final data = Map<String, dynamic>.from(d.data());
        data['userId'] = d.id;
        return TripMember.fromJson(data);
      }).toList();
      list.sort((a, b) => a.email.toLowerCase().compareTo(b.email.toLowerCase()));
      return List<TripMember>.unmodifiable(list);
    });
  },
);

/// Real-time activities under `group_trips/{tripId}/activities`.
final groupTripActivitiesStreamProvider =
    StreamProvider.family<List<TripActivity>, String>(
  (ref, tripId) {
    final db = ref.watch(firebaseFirestoreProvider);
    return db
        .collection(GroupTripPaths.collection)
        .doc(tripId)
        .collection(GroupTripPaths.activitiesSubcollection)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snap) {
      final list = snap.docs.map((d) {
        final data = Map<String, dynamic>.from(d.data());
        data['id'] = d.id;
        return TripActivity.fromJson(data);
      }).toList();
      list.sort((a, b) {
        final ta = a.scheduledAt;
        final tb = b.scheduledAt;
        if (ta != null && tb != null) {
          final c = ta.compareTo(tb);
          if (c != 0) return c;
        } else if (ta != null) {
          return -1;
        } else if (tb != null) {
          return 1;
        }
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });
      return List<TripActivity>.unmodifiable(list);
    });
  },
);
