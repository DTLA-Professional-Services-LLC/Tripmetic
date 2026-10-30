import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Firebase Auth session for optional cloud backup (null = guest / offline-only).
///
/// Backed by [FirebaseAuth.userChanges] — a superset of [authStateChanges] that
/// also fires on profile updates ([User.displayName], [User.email],
/// [User.photoURL], [User.updatePassword]). Widgets that show the current
/// display name (dashboard greeting, bucket-list share watermark, etc.) can
/// therefore rebuild as soon as [AccountManagementScreen] saves a new name,
/// without an app restart. Existing consumers that only care about
/// sign-in/out transitions (e.g. [bucketListProvider]) gate on `uid`
/// equality, so the extra profile-update emissions are harmless no-ops.
final firebaseAuthUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.userChanges();
});
