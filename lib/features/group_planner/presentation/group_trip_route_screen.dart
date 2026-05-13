import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n_helpers.dart';
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

    final resolved = ref.watch(resolvedGroupTripIdProvider(rawTripRef));

    return resolved.when(
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
    );
  }
}
