import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../application/group_planner_providers.dart';
import '../application/group_trip_service.dart';
import '../data/group_trip_paths.dart';
import '../domain/group_trip.dart';
import '../domain/group_trip_list_item.dart';
import '../domain/trip_budget_type.dart';
import 'widgets/edit_group_trip_sheet.dart';

/// Hub: plan a new group trip or join with an invite code.
class GroupPlannerLandingScreen extends ConsumerWidget {
  const GroupPlannerLandingScreen({super.key});

  void _showJoinSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => const _JoinGroupTripSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    final tripsAsync = ref.watch(myGroupTripsStreamProvider);
    final isPro = ref.watch(isTripmeticProProvider);

    Widget card({
      required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
    }) {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: cs.surfaceContainerHighest.withValues(alpha: 0.65),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: cs.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      );
    }

    Widget tripTile(GroupTripListItem item) {
      final t = item.trip;
      final fmt = MaterialLocalizations.of(
        context,
      ).formatMediumDate(t.startDate);
      final fmtEnd = MaterialLocalizations.of(
        context,
      ).formatMediumDate(t.endDate);
      final navId = t.inviteCode ?? t.id;
      return Card(
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 0,
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        child: ListTile(
          title: Text(
            t.destination,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '$fmt – $fmtEnd',
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.canEditTripSettings || item.canDeleteTrip)
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: cs.onSurfaceVariant,
                  ),
                  onSelected: (value) async {
                    if (value == 'edit' && item.canEditTripSettings) {
                      await showEditGroupTripSheet(
                        context: context,
                        trip: t,
                      );
                    } else if (value == 'delete' && item.canDeleteTrip) {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (dCtx) => AlertDialog(
                          title: Text(l10n.groupPlannerDeleteTripTitle),
                          content: Text(
                            l10n.groupPlannerDeleteTripBody(t.destination),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dCtx, false),
                              child: Text(l10n.groupPlannerCancel),
                            ),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(dCtx).colorScheme.error,
                                foregroundColor:
                                    Theme.of(dCtx).colorScheme.onError,
                              ),
                              onPressed: () => Navigator.pop(dCtx, true),
                              child: Text(l10n.groupPlannerDeleteTripAction),
                            ),
                          ],
                        ),
                      );
                      if (ok == true && context.mounted) {
                        try {
                          await ref
                              .read(groupTripServiceProvider)
                              .deleteTrip(t.id);
                          ref.invalidate(myGroupTripsStreamProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.groupPlannerTripDeleted),
                              ),
                            );
                          }
                        } on GroupPlannerException catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message)),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  l10n.groupPlannerTripDeleteError('$e'),
                                ),
                              ),
                            );
                          }
                        }
                      }
                    }
                  },
                  itemBuilder: (ctx) => [
                    if (item.canEditTripSettings)
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(l10n.groupPlannerEditTripAction),
                      ),
                    if (item.canDeleteTrip)
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(
                          l10n.groupPlannerDeleteTripAction,
                          style: TextStyle(color: cs.error),
                        ),
                      ),
                  ],
                ),
              Icon(
                Icons.chevron_right_rounded,
                color: cs.onSurfaceVariant,
              ),
            ],
          ),
          onTap: () => context.push('/group-trip/$navId'),
        ),
      );
    }

    return ProGlassOverlay(
      featureId: NavFeatureIds.groupPlanner,
      isPro: isPro,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.groupPlannerToolSubtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.groupPlannerMyTripsSectionTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          tripsAsync.when(
            data: (trips) {
              if (trips.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        l10n.groupPlannerMyTripsEmpty,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Text(
                      l10n.groupPlannerExamplesTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.groupPlannerExamplesSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _plannerDemoTripCard(
                      context,
                      theme,
                      cs,
                      l10n,
                      trip: _tripmeticSampleTripLisbon(),
                      headline: l10n.groupPlannerExampleLisbonTitle,
                    ),
                    const SizedBox(height: 8),
                    _plannerDemoTripCard(
                      context,
                      theme,
                      cs,
                      l10n,
                      trip: _tripmeticSampleTripKyoto(),
                      headline: l10n.groupPlannerExampleKyotoTitle,
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...trips.map((item) => tripTile(item)),
                  const SizedBox(height: 16),
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
            error: (_, _) => const SizedBox.shrink(),
          ),
          card(
            icon: Icons.add_circle_outline_rounded,
            title: l10n.groupPlannerLandingPlanTitle,
            subtitle: l10n.groupPlannerLandingPlanSubtitle,
            onTap: () => context.push('/group-planner/create'),
          ),
          const SizedBox(height: 12),
          card(
            icon: Icons.link_rounded,
            title: l10n.groupPlannerLandingJoinTitle,
            subtitle: l10n.groupPlannerLandingJoinSubtitle,
            onTap: () => _showJoinSheet(context),
          ),
        ],
      ),
    ),
    );
  }
}

GroupTrip _tripmeticSampleTripLisbon() {
  final start = DateTime.now().add(const Duration(days: 18));
  final end = start.add(const Duration(days: 5));
  return GroupTrip(
    id: '_demo_local',
    destination: 'Lisbon, Portugal',
    startDate: start,
    endDate: end,
    groupSize: 6,
    budgetType: TripBudgetType.perPerson,
    budgetAmount: 1400,
    ownerId: '',
    inviteCode: 'LISBON7',
  );
}

GroupTrip _tripmeticSampleTripKyoto() {
  final start = DateTime.now().add(const Duration(days: 45));
  final end = start.add(const Duration(days: 9));
  return GroupTrip(
    id: '_demo_local_2',
    destination: 'Kyoto, Japan',
    startDate: start,
    endDate: end,
    groupSize: 4,
    budgetType: TripBudgetType.group,
    budgetAmount: 5200,
    ownerId: '',
    inviteCode: 'KYOTO24',
  );
}

Widget _plannerDemoTripCard(
  BuildContext context,
  ThemeData theme,
  ColorScheme cs,
  AppLocalizations l10n, {
  required GroupTrip trip,
  required String headline,
}) {
  final loc = MaterialLocalizations.of(context);
  final fmtStart = loc.formatMediumDate(trip.startDate);
  final fmtEnd = loc.formatMediumDate(trip.endDate);
  return Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    color: cs.surfaceContainerHighest.withValues(alpha: 0.45),
    child: InkWell(
      onTap: () async {
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(headline),
            content: Text(l10n.groupPlannerExampleTapBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.commonOk),
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: cs.primary.withValues(alpha: 0.15),
              child: Icon(Icons.groups_rounded, color: cs.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trip.destination,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '$fmtStart – $fmtEnd · ${trip.groupSize} people',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.touch_app_outlined, color: cs.outline, size: 20),
          ],
        ),
      ),
    ),
  );
}

class _JoinGroupTripSheet extends StatefulWidget {
  const _JoinGroupTripSheet();

  @override
  State<_JoinGroupTripSheet> createState() => _JoinGroupTripSheetState();
}

class _JoinGroupTripSheetState extends State<_JoinGroupTripSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _open(BuildContext context) {
    final raw = _controller.text.trim();
    if (raw.isEmpty) return;
    final extracted = GroupTripPaths.extractTripRefFromUserInput(raw);
    if (extracted.isEmpty) return;
    Navigator.of(context).pop();
    context.push('/group-trip/${Uri.encodeComponent(extracted)}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final bottomSafe = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: bottomInset + bottomSafe + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.groupPlannerOpenSubtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: l10n.groupPlannerOpenTripCodeLabel,
              hintText: l10n.groupPlannerOpenHint,
              border: const OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _open(context),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => _open(context),
            child: Text(l10n.groupPlannerOpenButton),
          ),
        ],
      ),
    );
  }
}
