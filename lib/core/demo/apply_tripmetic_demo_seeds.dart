import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/bucket_list/application/bucket_list_provider.dart';
import '../../features/trip/application/trip_providers.dart';
import '../../features/vault/application/vault_providers.dart';

/// Writes one-time local demo content (itinerary, budget, bucket list, vault)
/// after Hive boxes are open. Safe to call on every cold start; each store
/// guards with its own flag / key checks.
Future<void> applyTripmeticDemoSeeds(ProviderContainer container) async {
  final appDir = await getApplicationDocumentsDirectory();

  await container.read(tripHiveStoreProvider).applyDemoSeedsIfNeeded();
  await container.read(bucketListHiveStoreProvider).applyDemoSeedsIfNeeded();
  await container.read(vaultHiveStoreProvider).applyDemoSeedsIfNeeded(appDir.path);

  container.invalidate(itineraryProvider);
  container.invalidate(tripBudgetProvider);
  container.invalidate(bucketListProvider);
  container.invalidate(vaultProvider);
}
