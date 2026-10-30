import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/notifications/fcm_service.dart';
import '../../../core/subscription/revenue_cat_identity.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../bucket_list/application/bucket_list_provider.dart';
import '../../group_planner/application/group_planner_providers.dart';
import 'user_profile_sync.dart';

/// After email sign-in or sign-up:
/// - link RevenueCat to Firebase uid
/// - upsert `users/{uid}`
/// - subscribe to FCM `all_users`
/// - sync bucket list / group trips
///
/// Uses [ProviderContainer] (not [WidgetRef]) so work can finish after the
/// auth screen is popped/disposed.
Future<void> syncUserCloudDataAfterLogin(
  ProviderContainer container, {
  String? displayNameOverride,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await revenueCatLogIn(user.uid);
    await ensureUserProfileDoc(
      user: user,
      displayNameOverride: displayNameOverride,
    );
    await FcmService.subscribeAllUsers();
    try {
      await container.read(customerInfoProvider.notifier).sync();
    } catch (_) {
      // Non-fatal: entitlement UI refreshes on next CustomerInfo update.
    }
  }

  try {
    await container.read(bucketListProvider.notifier).uploadLocalSnapshotToCloud();
  } catch (_) {
    // Non-fatal: user can retry from backup sheet or settings.
  }
  container.invalidate(bucketListProvider);
  container.invalidate(myGroupTripsStreamProvider);
}
