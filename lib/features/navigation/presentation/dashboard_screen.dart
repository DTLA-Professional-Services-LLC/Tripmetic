import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_nav.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../bucket_list/application/bucket_list_auth_providers.dart';
import '../../bucket_list/application/bucket_list_provider.dart';
import '../../bucket_list/domain/travel_destination.dart';
import '../../bucket_list/domain/travel_metrics.dart';
import '../../group_planner/domain/group_trip.dart';
import '../../paywall/presentation/pro_paywall_sheet.dart';
import '../application/dashboard_next_group_trip_provider.dart';

/// Modular home tab: welcome, next group trip, quick tools.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  static final _dateFmt = DateFormat.yMMMd();

  String _greetingName(AppLocalizations l10n, User? user) {
    final dn = user?.displayName?.trim();
    if (dn != null && dn.isNotEmpty) return dn;
    final email = user?.email?.trim();
    if (email != null && email.contains('@')) {
      return email.split('@').first;
    }
    return l10n.dashboardGuestName;
  }

  /// Empty/CTA state used for both `data: null` and `error` so the dashboard
  /// never renders a raw Firestore exception string.
  Widget _noUpcomingTripCard(
    ThemeData theme,
    ColorScheme cs,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: cs.primary.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.flight_takeoff_rounded, color: cs.primary),
            const SizedBox(height: 10),
            Text(
              l10n.dashboardNoUpcomingTripTitle,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.dashboardNoUpcomingTripBody,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _tripSubtitle(GroupTrip trip, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startDay =
        DateTime(trip.startDate.year, trip.startDate.month, trip.startDate.day);
    final endDay =
        DateTime(trip.endDate.year, trip.endDate.month, trip.endDate.day);
    if (today.isBefore(startDay)) {
      final days = startDay.difference(today).inDays;
      return l10n.dashboardCountdownStartsIn('$days');
    }
    if (!today.isAfter(endDay)) {
      final days = endDay.difference(today).inDays;
      return l10n.dashboardCountdownEndsIn('$days');
    }
    return '';
  }

  static Widget _worldExplorerCard(
    ThemeData theme,
    ColorScheme cs,
    AppLocalizations l10n,
    List<TravelDestination> list,
  ) {
    final metrics = TravelExplorationMetrics.fromDestinations(list);
    final visited = metrics.uniqueCountriesVisited;
    final pct = metrics.worldExploredPercent;
    final pctLabel =
        pct >= 10 ? pct.toStringAsFixed(0) : pct.toStringAsFixed(1);
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: cs.primary.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$visited',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      l10n.dashboardWorldExplorerCountriesLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                Text(
                  l10n.dashboardWorldExplorerPercentValue(pctLabel),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n.dashboardWorldExplorerPercentLabel,
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: pct / 100.0,
                minHeight: 10,
                backgroundColor: cs.surfaceContainerHighest,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final tripAsync = ref.watch(dashboardNextGroupTripProvider);
    final isPro = ref.watch(isTripmeticProProvider);
    final bucketAsync = ref.watch(bucketListProvider);
    // Listen to userChanges() (see [firebaseAuthUserProvider]) so the greeting
    // updates as soon as the user saves a new display name in the account
    // screen — no app restart required.
    final authUser = ref.watch(firebaseAuthUserProvider).valueOrNull;

    final quickIds = [
      NavFeatureIds.currency,
      NavFeatureIds.units,
      NavFeatureIds.offlineMap,
      NavFeatureIds.itinerary,
    ];

    return SafeArea(
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.dashboardGreeting(_greetingName(l10n, authUser)),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.dashboardWelcomeSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      if (!isPro) {
                        ProPaywallSheet.show(context);
                        return;
                      }
                      context.push('/group-planner/create');
                    },
                    icon: const Icon(Icons.groups_rounded),
                    label: Text(l10n.dashboardPlanGroupTrip),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => openNavFeature(context, ref, NavFeatureIds.bucketList),
                    icon: const Icon(Icons.star_border_rounded),
                    label: Text(l10n.dashboardAddBucketList),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                l10n.dashboardActiveTripSection,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: tripAsync.when(
                data: (item) {
                  if (item == null) {
                    return _noUpcomingTripCard(theme, cs, l10n);
                  }
                  final trip = item.trip;
                  final dates =
                      '${_dateFmt.format(trip.startDate)} – ${_dateFmt.format(trip.endDate)}';
                  final sub = _tripSubtitle(trip, l10n);
                  return Card(
                    elevation: 0,
                    color: cs.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: cs.primary.withValues(alpha: 0.45)),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        // Free users must not bypass the Pro gate via the
                        // dashboard snapshot — surface the upsell sheet instead
                        // of pushing the trip route. [GroupTripRouteScreen] wraps
                        // the resolved trip UI in [ProGlassOverlay] as defense in
                        // depth for deep links.
                        if (!isPro) {
                          ProPaywallSheet.show(context);
                          return;
                        }
                        context.push(
                          '/group-trip/${Uri.encodeComponent(trip.id)}',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    trip.destination,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right_rounded, color: cs.primary),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dates,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            if (sub.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                sub,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: cs.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                // Render the empty/CTA state on error instead of leaking raw
                // `[cloud_firestore/...]` exception text to the user.
                error: (_, _) => _noUpcomingTripCard(theme, cs, l10n),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                l10n.dashboardQuickToolsSection,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final id = quickIds[index];
                  final tierFree = NavFeatureRoutes.isFree(id);
                  final lockedPro = NavFeatureRoutes.isPro(id) && !isPro;
                  final borderColor = tierFree
                      ? AppColors.freeTier.withValues(alpha: 0.55)
                      : AppColors.accent.withValues(alpha: 0.38);
                  final iconColor = tierFree ? AppColors.freeTier : cs.primary;
                  return Material(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => openNavFeature(context, ref, id),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(navFeatureIcon(id), color: iconColor, size: 28),
                                const Spacer(),
                                if (tierFree)
                                  Text(
                                    l10n.navFeatureBadgeFree,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: AppColors.freeTier,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  )
                                else if (lockedPro)
                                  Icon(
                                    Icons.workspace_premium_outlined,
                                    color: AppColors.accent,
                                    size: 22,
                                  ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              navFeatureTitle(l10n, id),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              navFeatureSubtitle(l10n, id),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: quickIds.length,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                l10n.dashboardWorldExplorerSection,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverToBoxAdapter(
              child: bucketAsync.when(
                data: (list) =>
                    _worldExplorerCard(theme, cs, l10n, list),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, _) =>
                    _worldExplorerCard(theme, cs, l10n, const []),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
