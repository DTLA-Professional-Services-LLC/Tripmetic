import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bucket_list/application/bucket_list_provider.dart';
import '../../group_planner/application/group_planner_providers.dart';

/// After email sign-in or sign-up, push local bucket list to Firestore and
/// refresh cloud-backed providers (bucket list merge, group trips list).
Future<void> syncUserCloudDataAfterLogin(WidgetRef ref) async {
  try {
    await ref.read(bucketListProvider.notifier).uploadLocalSnapshotToCloud();
  } catch (_) {
    // Non-fatal: user can retry from backup sheet or settings.
  }
  ref.invalidate(bucketListProvider);
  ref.invalidate(myGroupTripsStreamProvider);
}
