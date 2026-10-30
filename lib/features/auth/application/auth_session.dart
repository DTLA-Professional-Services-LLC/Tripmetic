import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/notifications/fcm_service.dart';
import '../../../core/subscription/revenue_cat_identity.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../bucket_list/application/bucket_list_auth_providers.dart';
import '../../bucket_list/application/bucket_list_provider.dart';
import '../../group_planner/application/group_planner_providers.dart';

/// Signs out of Firebase, RevenueCat, and FCM topic subscription.
Future<void> signOutTripmeticSession([WidgetRef? ref]) async {
  await FcmService.unsubscribeAllUsers();
  await revenueCatLogOut();
  await FirebaseAuth.instance.signOut();
  if (ref != null) {
    ref.invalidate(firebaseAuthUserProvider);
    ref.invalidate(bucketListProvider);
    ref.invalidate(myGroupTripsStreamProvider);
    try {
      await ref.read(customerInfoProvider.notifier).sync();
    } catch (_) {
      // Non-fatal: UI will refresh on next CustomerInfo update.
    }
  }
}
