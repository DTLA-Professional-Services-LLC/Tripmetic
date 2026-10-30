import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/bucket_list/application/bucket_list_auth_providers.dart';

/// Admin / redeem lifetime grants live on `users/{uid}` in Firestore.
///
/// Settings and Pro gates historically only read RevenueCat [CustomerInfo], which
/// can lag after a promotional grant. Watching this flag keeps the UI aligned
/// with the admin console even when the RC cache is stale.
final firestoreLifetimeAccessProvider = StreamProvider<bool>((ref) {
  final user = ref.watch(firebaseAuthUserProvider).valueOrNull;
  if (user == null) {
    return Stream<bool>.value(false);
  }
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .snapshots()
      .map(_hasLifetimeAccess);
});

bool _hasLifetimeAccess(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data();
  if (data == null) return false;
  if (data['lifetime_access'] == true) return true;
  final status = (data['entitlement_status'] as String?)?.trim().toLowerCase();
  return status == 'lifetime';
}
