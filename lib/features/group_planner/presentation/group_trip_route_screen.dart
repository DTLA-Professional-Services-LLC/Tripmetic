import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../application/group_planner_providers.dart';
import '../application/group_trip_service.dart';
import 'group_trip_dashboard_screen.dart';

/// Resolves a route param (trip UUID, short invite code, or pasted URL) to a Firestore trip id.
class GroupTripRouteScreen extends ConsumerWidget {
  const GroupTripRouteScreen({
    super.key,
    required this.rawTripRef,
  });

  final String rawTripRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final isPro = ref.watch(isTripmeticProProvider);

    final resolved = ref.watch(resolvedGroupTripIdProvider(rawTripRef));

    // Single gate for the whole route (loading / error / dashboard). The
    // [Scaffold]'s FAB and [AppBar] actions sit *above* a body-only overlay,
    // so wrapping here keeps free users fully locked out of group trips.
    return ProGlassOverlay(
      featureId: NavFeatureIds.groupPlanner,
      isPro: isPro,
      child: resolved.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          final msg = err is GroupPlannerException ? err.message : '$err';
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                l10n.groupPlannerUnknownTripCode(msg),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(color: cs.error),
              ),
            ),
          );
        },
        data: (tripId) => GroupTripDashboardScreen(tripId: tripId),
      ),
    );
  }
}
