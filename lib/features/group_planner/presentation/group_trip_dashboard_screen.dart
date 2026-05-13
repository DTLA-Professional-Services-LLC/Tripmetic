import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../../bucket_list/application/bucket_list_auth_providers.dart';
import '../application/group_planner_providers.dart';
import '../application/group_trip_service.dart';
import '../domain/group_trip.dart';
import '../domain/trip_budget_type.dart';
import '../domain/trip_activity.dart';
import '../domain/trip_member.dart';
import '../domain/trip_member_role.dart';
import 'widgets/group_activity_card.dart';
import 'widgets/manage_members_sheet.dart';

/// Live dashboard: trip summary, invite / manage members, activity feed with voting.
class GroupTripDashboardScreen extends ConsumerWidget {
  const GroupTripDashboardScreen({super.key, required this.tripId});

  final String tripId;

  bool _isTripAdmin(GroupTrip? trip, TripMember? self, String? uid) {
    if (uid == null || trip == null) return false;
    if (trip.ownerId == uid) return true;
    return self?.role == TripMemberRole.admin;
  }

  String _formatMoney(BuildContext context, double amount) {
    final locale = Localizations.localeOf(context).toString();
    return NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: locale,
    ).format(amount);
  }

  String _budgetLine(
    BuildContext context,
    GroupTrip trip,
    AppLocalizations l10n,
  ) {
    final amt = _formatMoney(context, trip.budgetAmount);
    return switch (trip.budgetType) {
      TripBudgetType.none => l10n.groupPlannerBudgetNone,
      TripBudgetType.perPerson => l10n.groupPlannerBudgetPerPerson(amt),
      TripBudgetType.group => l10n.groupPlannerBudgetGroup(amt),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    final auth = ref.watch(firebaseAuthUserProvider);
    final uid = auth.valueOrNull?.uid;
    final isPro = ref.watch(isTripmeticProProvider);

    final tripAsync = ref.watch(groupTripStreamProvider(tripId));
    final membersAsync = ref.watch(groupTripMembersStreamProvider(tripId));
    final activitiesAsync = ref.watch(
      groupTripActivitiesStreamProvider(tripId),
    );

    // Soft paywall: every render path of this Pro screen is wrapped so free
    // users who reach it (e.g. via a stale deep link or future regression in
    // the dashboard) see the Tripmetic Pro lock — never raw trip content.
    Widget gate(Widget body) => ProGlassOverlay(
          featureId: NavFeatureIds.groupPlanner,
          isPro: isPro,
          child: body,
        );

    if (tripAsync.isLoading ||
        membersAsync.isLoading ||
        activitiesAsync.isLoading) {
      return gate(const Center(child: CircularProgressIndicator()));
    }

    if (tripAsync.hasError ||
        membersAsync.hasError ||
        activitiesAsync.hasError) {
      final err =
          tripAsync.error ?? membersAsync.error ?? activitiesAsync.error;
      return gate(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              '$err',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(color: cs.error),
            ),
          ),
        ),
      );
    }

    final trip = tripAsync.valueOrNull;
    final members = membersAsync.value ?? const <TripMember>[];
    final activities = activitiesAsync.value ?? const [];

    if (uid == null) {
      return gate(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  size: 48,
                  color: cs.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.groupPlannerSignInTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.groupPlannerSignInBody,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (trip == null) {
      return gate(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              l10n.groupPlannerTripNotFound,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    TripMember? selfMember;
    for (final m in members) {
      if (m.userId == uid) {
        selfMember = m;
        break;
      }
    }

    final canAdminUi = _isTripAdmin(trip, selfMember, uid);
    final membersMap = {for (final m in members) m.userId: m};

    final dateFmt = DateFormat.yMMMd();

    final canAddActivity =
        selfMember != null && selfMember.role.canPlanActivities;

    return gate(Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.destination,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _DashRow(
                          icon: Icons.calendar_today_outlined,
                          label: l10n.groupPlannerDates,
                          value:
                              '${dateFmt.format(trip.startDate)} – ${dateFmt.format(trip.endDate)}',
                        ),
                        const SizedBox(height: 8),
                        _DashRow(
                          icon: Icons.groups_outlined,
                          label: l10n.groupPlannerGroupSize,
                          value: l10n.groupPlannerPeopleCount(
                            '${trip.groupSize}',
                          ),
                        ),
                        const SizedBox(height: 8),
                        _DashRow(
                          icon: Icons.payments_outlined,
                          label: l10n.groupPlannerBudget,
                          value: _budgetLine(context, trip, l10n),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () async {
                        try {
                          await ref
                              .read(groupTripServiceProvider)
                              .shareEmailInvitation(
                                tripId: tripId,
                                destinationLabel: trip.destination,
                              );
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  l10n.groupPlannerInviteError('$e'),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.mail_outline_rounded),
                      label: Text(l10n.groupPlannerInviteMembers),
                    ),
                    if (canAdminUi)
                      OutlinedButton.icon(
                        onPressed: () => ManageMembersSheet.show(
                          context: context,
                          tripId: tripId,
                          trip: trip,
                          members: members,
                        ),
                        icon: const Icon(Icons.manage_accounts_outlined),
                        label: Text(l10n.groupPlannerManageMembers),
                      ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  l10n.groupPlannerItinerary,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            if (activities.isEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    l10n.groupPlannerNoActivities,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 96),
                sliver: SliverList.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, i) {
                    final a = activities[i];
                    return GroupActivityCard(
                      tripId: tripId,
                      activity: a,
                      membersByUserId: membersMap,
                      currentUserId: selfMember != null ? uid : null,
                      canManageItinerary: canAddActivity,
                      onEditActivity: canAddActivity
                          ? (act) => _showEditActivityDialog(
                                context,
                                ref,
                                tripId,
                                act,
                                l10n,
                              )
                          : null,
                      onDeleteActivity: canAddActivity
                          ? (act) => _confirmDeleteActivity(
                                context,
                                ref,
                                tripId,
                                act,
                                l10n,
                              )
                          : null,
                    );
                  },
                ),
              ),
          ],
        ),
        if (canAddActivity)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () =>
                  _showAddActivityDialog(context, ref, tripId, l10n),
              tooltip: l10n.groupPlannerAddActivity,
              child: const Icon(Icons.add_rounded),
            ),
          ),
      ],
    ));
  }
}

Future<void> _showAddActivityDialog(
  BuildContext context,
  WidgetRef ref,
  String tripId,
  AppLocalizations l10n,
) async {
  final titleCtrl = TextEditingController();
  final notesCtrl = TextEditingController();
  final linkCtrl = TextEditingController();
  try {
    final submit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.groupPlannerAddActivity),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  labelText: l10n.groupPlannerActivityTitleLabel,
                  border: const OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesCtrl,
                decoration: InputDecoration(
                  labelText: l10n.groupPlannerNotes,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: linkCtrl,
                decoration: InputDecoration(
                  labelText: l10n.groupPlannerOpenLink,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.groupPlannerCancel),
          ),
          FilledButton(
            onPressed: () {
              if (titleCtrl.text.trim().isEmpty) return;
              Navigator.pop(ctx, true);
            },
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
    if (submit != true || !context.mounted) return;
    await ref
        .read(groupTripServiceProvider)
        .addActivity(
          tripId: tripId,
          title: titleCtrl.text,
          notes: notesCtrl.text,
          link: linkCtrl.text.trim().isEmpty ? null : linkCtrl.text.trim(),
        );
  } on GroupPlannerException catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  } finally {
    titleCtrl.dispose();
    notesCtrl.dispose();
    linkCtrl.dispose();
  }
}

Future<void> _showEditActivityDialog(
  BuildContext context,
  WidgetRef ref,
  String tripId,
  TripActivity activity,
  AppLocalizations l10n,
) async {
  final titleCtrl = TextEditingController(text: activity.title);
  final notesCtrl = TextEditingController(text: activity.notes);
  final linkCtrl = TextEditingController(text: activity.link ?? '');
  try {
    final submit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.groupPlannerEditActivity),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  labelText: l10n.groupPlannerActivityTitleLabel,
                  border: const OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesCtrl,
                decoration: InputDecoration(
                  labelText: l10n.groupPlannerNotes,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: linkCtrl,
                decoration: InputDecoration(
                  labelText: l10n.groupPlannerOpenLink,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.groupPlannerCancel),
          ),
          FilledButton(
            onPressed: () {
              if (titleCtrl.text.trim().isEmpty) return;
              Navigator.pop(ctx, true);
            },
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
    if (submit != true || !context.mounted) return;
    await ref.read(groupTripServiceProvider).updateActivity(
          tripId: tripId,
          activityId: activity.id,
          title: titleCtrl.text,
          notes: notesCtrl.text,
          link: linkCtrl.text.trim().isEmpty ? null : linkCtrl.text.trim(),
        );
  } on GroupPlannerException catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.groupPlannerActivityEditError('$e'))),
      );
    }
  } finally {
    titleCtrl.dispose();
    notesCtrl.dispose();
    linkCtrl.dispose();
  }
}

Future<void> _confirmDeleteActivity(
  BuildContext context,
  WidgetRef ref,
  String tripId,
  TripActivity activity,
  AppLocalizations l10n,
) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.groupPlannerDeleteActivityTitle),
      content: Text(l10n.groupPlannerDeleteActivityBody(activity.title)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(l10n.groupPlannerCancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(ctx).colorScheme.error,
            foregroundColor: Theme.of(ctx).colorScheme.onError,
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(l10n.groupPlannerDeleteActivity),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) return;
  try {
    await ref.read(groupTripServiceProvider).deleteActivity(
          tripId: tripId,
          activityId: activity.id,
        );
  } on GroupPlannerException catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.groupPlannerActivityDeleteError('$e'))),
      );
    }
  }
}

class _DashRow extends StatelessWidget {
  const _DashRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: cs.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(value, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
