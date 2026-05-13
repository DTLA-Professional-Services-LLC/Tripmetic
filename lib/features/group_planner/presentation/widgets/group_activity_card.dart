import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/l10n_helpers.dart';
import '../../application/group_planner_providers.dart';
import '../../domain/trip_activity.dart';
import '../../domain/trip_member.dart';
import '../group_trip_colors.dart';

class GroupActivityCard extends ConsumerStatefulWidget {
  const GroupActivityCard({
    super.key,
    required this.tripId,
    required this.activity,
    required this.membersByUserId,
    required this.currentUserId,
    this.canManageItinerary = false,
    this.onEditActivity,
    this.onDeleteActivity,
  });

  final String tripId;
  final TripActivity activity;
  final Map<String, TripMember> membersByUserId;
  final String? currentUserId;
  final bool canManageItinerary;
  final ValueChanged<TripActivity>? onEditActivity;
  final ValueChanged<TripActivity>? onDeleteActivity;

  @override
  ConsumerState<GroupActivityCard> createState() => _GroupActivityCardState();
}

class _GroupActivityCardState extends ConsumerState<GroupActivityCard> {
  bool _expanded = false;

  int get _netVotes =>
      widget.activity.votes.values.fold<int>(0, (a, b) => a + b);

  int? get _myVote =>
      widget.currentUserId != null ? widget.activity.votes[widget.currentUserId!] : null;

  Future<void> _vote(int value) async {
    final l10n = context.l10n;
    try {
      await ref.read(groupTripServiceProvider).castVoteOnActivity(
            tripId: widget.tripId,
            activityId: widget.activity.id,
            value: value,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.groupPlannerVoteError('$e'))),
        );
      }
    }
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.groupPlannerOpenLink)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    final planner = widget.membersByUserId[widget.activity.plannedByUserId];
    final accent = parseTripPlannerHexColor(planner?.colorCode);
    final plannerEmail = planner?.email ?? widget.activity.plannedByUserId;

    final myVote = _myVote;
    final showManageMenu = widget.canManageItinerary &&
        (widget.onEditActivity != null || widget.onDeleteActivity != null);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 12,
              color: accent,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.activity.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  plannerEmail,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (showManageMenu)
                                PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert_rounded,
                                    color: cs.onSurfaceVariant,
                                  ),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      widget.onEditActivity?.call(widget.activity);
                                    } else if (value == 'delete') {
                                      widget.onDeleteActivity?.call(widget.activity);
                                    }
                                  },
                                  itemBuilder: (ctx) => [
                                    if (widget.onEditActivity != null)
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text(l10n.groupPlannerEditActivity),
                                      ),
                                    if (widget.onDeleteActivity != null)
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text(
                                          l10n.groupPlannerDeleteActivity,
                                          style: TextStyle(color: cs.error),
                                        ),
                                      ),
                                  ],
                                ),
                              IconButton(
                                tooltip: 'Up',
                                onPressed: widget.currentUserId == null ? null : () => _vote(1),
                                icon: Icon(
                                  myVote == 1
                                      ? Icons.thumb_up_rounded
                                      : Icons.thumb_up_outlined,
                                  color: myVote == 1 ? cs.primary : cs.onSurfaceVariant,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  l10n.groupPlannerNetVotes('$_netVotes'),
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              IconButton(
                                tooltip: 'Down',
                                onPressed: widget.currentUserId == null ? null : () => _vote(-1),
                                icon: Icon(
                                  myVote == -1
                                      ? Icons.thumb_down_rounded
                                      : Icons.thumb_down_outlined,
                                  color: myVote == -1 ? cs.error : cs.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: _expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox(width: double.infinity, height: 0),
                    secondChild: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.activity.notes.trim().isNotEmpty) ...[
                            Text(
                              l10n.groupPlannerNotes,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SelectableText(
                              widget.activity.notes,
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                          ],
                          if (widget.activity.link != null &&
                              widget.activity.link!.trim().isNotEmpty) ...[
                            Text(
                              l10n.groupPlannerOpenLink,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () => _openLink(widget.activity.link!),
                              child: Text(
                                widget.activity.link!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: cs.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                          if (widget.activity.notes.trim().isEmpty &&
                              (widget.activity.link == null ||
                                  widget.activity.link!.trim().isEmpty))
                            Text(
                              l10n.groupPlannerNoExtraDetails,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
