import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/l10n_helpers.dart';
import '../../application/group_planner_providers.dart';
import '../../domain/group_trip.dart';
import '../../domain/trip_member.dart';
import '../../domain/trip_member_role.dart';

/// Modal bottom sheet: list members, change roles, remove (admin / owner only).
class ManageMembersSheet extends ConsumerWidget {
  const ManageMembersSheet({
    super.key,
    required this.tripId,
    required this.trip,
    required this.members,
  });

  final String tripId;
  final GroupTrip trip;
  final List<TripMember> members;

  static Future<void> show({
    required BuildContext context,
    required String tripId,
    required GroupTrip trip,
    required List<TripMember> members,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => ManageMembersSheet(
        tripId: tripId,
        trip: trip,
        members: members,
      ),
    );
  }

  String _roleLabel(AppLocalizations l10n, TripMemberRole role) {
    return switch (role) {
      TripMemberRole.admin => l10n.groupPlannerRoleAdmin,
      TripMemberRole.coPlanner => l10n.groupPlannerRoleCoPlanner,
      TripMemberRole.viewOnly => l10n.groupPlannerRoleViewOnly,
    };
  }

  Future<void> _confirmRemove(
    BuildContext context,
    WidgetRef ref,
    TripMember member,
  ) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.groupPlannerRemoveMemberTitle),
        content: Text(l10n.groupPlannerRemoveMemberBody(member.email)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.groupPlannerCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.groupPlannerRemoveMember),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;

    try {
      await ref.read(groupTripServiceProvider).removeMember(
            tripId: tripId,
            userId: member.userId,
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.groupPlannerManageError('$e'))),
        );
      }
    }
  }

  Future<void> _updateRole(
    BuildContext context,
    WidgetRef ref,
    TripMember member,
    TripMemberRole role,
  ) async {
    final l10n = context.l10n;
    try {
      await ref.read(groupTripServiceProvider).updateMemberRole(
            tripId: tripId,
            userId: member.userId,
            newRole: role,
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.groupPlannerManageError('$e'))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.groupPlannerMembersTitle,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.55,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: members.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = members[i];
                final isOwner = m.userId == trip.ownerId;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    m.email.isNotEmpty ? m.email : m.userId,
                    style: theme.textTheme.bodyLarge,
                  ),
                  subtitle: isOwner
                      ? Text(
                          '${l10n.groupPlannerOwner} · ${_roleLabel(l10n, TripMemberRole.admin)}',
                          style: theme.textTheme.labelSmall?.copyWith(color: cs.primary),
                        )
                      : Text(_roleLabel(l10n, m.role)),
                  trailing: isOwner
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton<TripMemberRole>(
                              value: m.role,
                              underline: const SizedBox.shrink(),
                              items: TripMemberRole.values
                                  .map(
                                    (r) => DropdownMenuItem(
                                      value: r,
                                      child: Text(_roleLabel(l10n, r)),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (next) {
                                if (next != null && next != m.role) {
                                  _updateRole(context, ref, m, next);
                                }
                              },
                            ),
                            IconButton(
                              tooltip: l10n.groupPlannerRemoveMember,
                              icon: Icon(Icons.person_remove_outlined, color: cs.error),
                              onPressed: () => _confirmRemove(context, ref, m),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
          ],
      ),
    );
  }
}
