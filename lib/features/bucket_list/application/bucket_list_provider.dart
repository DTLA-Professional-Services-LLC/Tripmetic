import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';

import '../data/bucket_list_firestore_mapper.dart';
import '../data/bucket_list_hive_store.dart';
import '../domain/bucket_list_merge.dart';
import '../domain/travel_destination.dart';
import '../domain/us_state_from_coordinates.dart';
import 'bucket_list_auth_providers.dart';

final bucketListHiveStoreProvider = Provider<BucketListHiveStore>((ref) {
  return BucketListHiveStore();
});

final bucketListHiveStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.read(bucketListHiveStoreProvider).open();
});

final bucketListProvider =
    AsyncNotifierProvider<BucketListNotifier, List<TravelDestination>>(
  BucketListNotifier.new,
);

class BucketListNotifier extends AsyncNotifier<List<TravelDestination>> {
  static const _uuid = Uuid();
  static const _batchSize = 450;

  FirebaseFirestore get _db => FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _bucketCol(String userId) =>
      _db.collection('users').doc(userId).collection('bucket_list');

  List<TravelDestination> _sorted(List<TravelDestination> list) {
    final copy = [...list]..sort((a, b) => a.displayName.compareTo(b.displayName));
    return List<TravelDestination>.unmodifiable(copy);
  }

  TravelDestination _touched(TravelDestination d) {
    return d.copyWith(
      lastModifiedMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<void> _persistLocal(List<TravelDestination> list) async {
    final store = ref.read(bucketListHiveStoreProvider);
    await store.saveDestinations(list);
  }

  /// CRUD may run before [build] finishes loading (AsyncLoading / AsyncError).
  List<TravelDestination> _currentOrHive() {
    return state.maybeWhen(
      data: (list) => list,
      orElse: () {
        final store = ref.read(bucketListHiveStoreProvider);
        return store.loadDestinations();
      },
    );
  }

  Future<List<TravelDestination>> _fetchRemote(String userId) async {
    final snap = await _bucketCol(userId)
        .get(const GetOptions(source: Source.serverAndCache))
        .timeout(const Duration(seconds: 20));
    return snap.docs
        .map(BucketListFirestoreMapper.fromSnapshot)
        .whereType<TravelDestination>()
        .toList();
  }

  /// Writes every destination document (used after merge and for explicit backup).
  Future<void> _pushAllRemote(String userId, List<TravelDestination> list) async {
    if (list.isEmpty) return;
    var i = 0;
    while (i < list.length) {
      final batch = _db.batch();
      final end = (i + _batchSize < list.length) ? i + _batchSize : list.length;
      for (var j = i; j < end; j++) {
        final d = list[j];
        batch.set(
          _bucketCol(userId).doc(d.id),
          BucketListFirestoreMapper.toMap(d),
        );
      }
      await batch.commit();
      i = end;
    }
  }

  Future<void> _setRemote(String userId, TravelDestination d) async {
    await _bucketCol(userId)
        .doc(d.id)
        .set(BucketListFirestoreMapper.toMap(d));
  }

  Future<void> _deleteRemote(String userId, String id) async {
    await _bucketCol(userId).doc(id).delete();
  }

  @override
  Future<List<TravelDestination>> build() async {
    ref.listen<AsyncValue<User?>>(firebaseAuthUserProvider, (prev, next) {
      final pu = prev?.valueOrNull?.uid;
      final nu = next.valueOrNull?.uid;
      if (pu != nu) {
        ref.invalidateSelf();
      }
    });

    await ref.watch(bucketListHiveStoreReadyProvider.future);
    final store = ref.read(bucketListHiveStoreProvider);
    var list = store.loadDestinations();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final remote = await _fetchRemote(user.uid);
        list = mergeBucketListById(list, remote);
        await _persistLocal(list);
        try {
          await _pushAllRemote(user.uid, list)
              .timeout(const Duration(seconds: 45));
        } catch (_) {
          // Offline or write failure — local copy is already saved.
        }
      } catch (_) {
        // Offline, timeout, or permission: keep Hive snapshot only.
      }
    }

    return _sorted(list);
  }

  String newId() => _uuid.v4();

  /// After email/password sign-up, push the current Hive snapshot to Firestore.
  Future<void> uploadLocalSnapshotToCloud() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await ref.read(bucketListHiveStoreReadyProvider.future);
    final store = ref.read(bucketListHiveStoreProvider);
    final list = store.loadDestinations();
    await _pushAllRemote(user.uid, list);
  }

  Future<void> addDestination(TravelDestination destination) async {
    final withMeta = _touched(destination);
    final user = FirebaseAuth.instance.currentUser;

    final current = _currentOrHive();
    final next = _sorted([...current, withMeta]);
    await _persistLocal(next);
    state = AsyncData(next);

    if (user != null) {
      await _setRemote(user.uid, withMeta);
    }
  }

  Future<void> editDestination(TravelDestination updated) async {
    final withMeta = _touched(updated);
    final user = FirebaseAuth.instance.currentUser;

    final current = _currentOrHive();
    final next = _sorted(
      current.map((d) => d.id == withMeta.id ? withMeta : d).toList(),
    );
    await _persistLocal(next);
    state = AsyncData(next);

    if (user != null) {
      await _setRemote(user.uid, withMeta);
    }
  }

  Future<void> deleteDestination(String id) async {
    final user = FirebaseAuth.instance.currentUser;

    final current = _currentOrHive();
    final next =
        _sorted(current.where((d) => d.id != id).toList(growable: false));
    await _persistLocal(next);
    state = AsyncData(next);

    if (user != null) {
      await _deleteRemote(user.uid, id);
    }
  }

  /// Matches [city] + [country] (case-insensitive) for a single [category].
  TravelDestination? findDestination({
    required List<TravelDestination> list,
    required String city,
    required String country,
    required TravelDestinationCategory category,
  }) {
    final c = city.trim().toLowerCase();
    final co = country.trim().toLowerCase();
    for (final d in list) {
      if (d.category != category) continue;
      if (d.city.trim().toLowerCase() == c &&
          d.country.trim().toLowerCase() == co) {
        return d;
      }
    }
    return null;
  }

  Future<String?> _resolveUsStateForCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final marks = await placemarkFromCoordinates(latitude, longitude);
      if (marks.isNotEmpty) {
        final admin = marks.first.administrativeArea;
        final fromAdmin = resolveUsStateFromAdminArea(admin);
        if (fromAdmin != null) return fromAdmin;
      }
    } catch (_) {
      // Offline or platform geocoder unavailable — fall back below.
    }
    return inferUsStateFromCoordinates(latitude, longitude);
  }

  /// Toggles a city on/off for [category] using the same persistence as the editor sheet.
  Future<void> toggleDestinationCategory({
    required String city,
    required String country,
    required double latitude,
    required double longitude,
    required TravelDestinationCategory category,
  }) async {
    final current = _currentOrHive();
    final existing = findDestination(
      list: current,
      city: city,
      country: country,
      category: category,
    );
    if (existing != null) {
      await deleteDestination(existing.id);
      return;
    }

    final countryTrim = country.trim();
    String? state;
    if (destinationCountryIsUnitedStates(countryTrim)) {
      state = await _resolveUsStateForCoordinates(latitude, longitude);
    }

    await addDestination(
      TravelDestination(
        id: newId(),
        city: city.trim(),
        country: countryTrim,
        state: state,
        latitude: latitude,
        longitude: longitude,
        category: category,
      ),
    );
  }
}
