import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/l10n_helpers.dart';
import '../../application/group_planner_providers.dart';
import '../../application/group_trip_service.dart';
import '../../domain/group_trip.dart';
import '../../domain/trip_activity.dart';

/// Modal editor for adding or editing a group-trip activity. Uses a bottom sheet
/// so the layout responds to the keyboard and scrolls on small screens.
Future<void> showGroupActivityEditorSheet({
  required BuildContext context,
  required String tripId,
  required GroupTrip trip,
  TripActivity? existing,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (ctx) {
      final h = MediaQuery.sizeOf(ctx).height;
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: h * 0.92),
          child: GroupActivityEditorBody(
            tripId: tripId,
            trip: trip,
            existing: existing,
          ),
        ),
      );
    },
  );
}

class GroupActivityEditorBody extends ConsumerStatefulWidget {
  const GroupActivityEditorBody({
    super.key,
    required this.tripId,
    required this.trip,
    this.existing,
  });

  final String tripId;
  final GroupTrip trip;
  final TripActivity? existing;

  @override
  ConsumerState<GroupActivityEditorBody> createState() =>
      _GroupActivityEditorBodyState();
}

class _GroupActivityEditorBodyState extends ConsumerState<GroupActivityEditorBody> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _notesCtrl;
  late final TextEditingController _linkCtrl;
  late DateTime _scheduled;
  bool _busy = false;

  static DateTime _dateOnly(DateTime d) => DateUtils.dateOnly(d);

  static DateTime _initialSchedule(GroupTrip trip, TripActivity? existing) {
    final existingAt = existing?.scheduledAt;
    if (existingAt != null) return existingAt;
    final start = _dateOnly(trip.startDate.toLocal());
    return DateTime(start.year, start.month, start.day, 9, 0);
  }

  bool _isWithinTrip(DateTime when) {
    final day = _dateOnly(when.toLocal());
    final start = _dateOnly(widget.trip.startDate.toLocal());
    final end = _dateOnly(widget.trip.endDate.toLocal());
    return !day.isBefore(start) && !day.isAfter(end);
  }

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _titleCtrl = TextEditingController(text: ex?.title ?? '');
    _notesCtrl = TextEditingController(text: ex?.notes ?? '');
    _linkCtrl = TextEditingController(text: ex?.link ?? '');
    _scheduled = _initialSchedule(widget.trip, ex);
    if (!_isWithinTrip(_scheduled)) {
      final start = _dateOnly(widget.trip.startDate.toLocal());
      _scheduled = DateTime(start.year, start.month, start.day, 9, 0);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _notesCtrl.dispose();
    _linkCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final start = _dateOnly(widget.trip.startDate.toLocal());
    final end = _dateOnly(widget.trip.endDate.toLocal());
    final currentDay = _dateOnly(_scheduled.toLocal());
    final initial = currentDay.isBefore(start)
        ? start
        : currentDay.isAfter(end)
            ? end
            : currentDay;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: start,
      lastDate: end,
      locale: locale,
      helpText: l10n.groupPlannerActivityTripDateRangeHelp,
    );
    if (picked == null || !mounted) return;
    final loc = _scheduled.toLocal();
    setState(() {
      _scheduled = DateTime(
        picked.year,
        picked.month,
        picked.day,
        loc.hour,
        loc.minute,
      );
    });
  }

  Future<void> _pickTime() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final loc = _scheduled.toLocal();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: loc.hour, minute: loc.minute),
    );
    if (picked == null || !mounted) return;
    final d = _scheduled.toLocal();
    setState(() {
      _scheduled = DateTime(d.year, d.month, d.day, picked.hour, picked.minute);
    });
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.groupPlannerActivityTitleRequired)),
      );
      return;
    }
    if (!_isWithinTrip(_scheduled)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.groupPlannerActivityDateOutOfRange)),
      );
      return;
    }

    setState(() => _busy = true);
    try {
      final svc = ref.read(groupTripServiceProvider);
      final linkText = _linkCtrl.text.trim();
      final link = linkText.isEmpty ? null : linkText;
      if (widget.existing == null) {
        await svc.addActivity(
          tripId: widget.tripId,
          title: title,
          scheduledAt: _scheduled,
          notes: _notesCtrl.text,
          link: link,
        );
      } else {
        await svc.updateActivity(
          tripId: widget.tripId,
          activityId: widget.existing!.id,
          title: title,
          scheduledAt: _scheduled,
          notes: _notesCtrl.text,
          link: link,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } on GroupPlannerException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.existing == null
                  ? '$e'
                  : l10n.groupPlannerActivityEditError('$e'),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final isEdit = widget.existing != null;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final dateFmt = DateFormat.yMMMd(localeTag);
    final timeFmt = DateFormat.jm(localeTag);
    final loc = _scheduled.toLocal();

    return Material(
      color: cs.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    isEdit ? l10n.groupPlannerEditActivity : l10n.groupPlannerAddActivity,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Text(l10n.commonKeyboardDone),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                  onPressed: _busy ? null : () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.groupPlannerActivityTripDateRangeHelp,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _titleCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.groupPlannerActivityTitleLabel,
                      border: const OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.groupPlannerActivityWhenLabel,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _busy ? null : _pickDate,
                          icon: const Icon(Icons.calendar_today_outlined, size: 18),
                          label: Text(dateFmt.format(loc)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _busy ? null : _pickTime,
                          icon: const Icon(Icons.schedule_rounded, size: 18),
                          label: Text(timeFmt.format(loc)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _notesCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.groupPlannerNotes,
                      border: const OutlineInputBorder(),
                    ),
                    minLines: 2,
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _linkCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.groupPlannerOpenLink,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                TextButton(
                  onPressed: _busy ? null : () => Navigator.of(context).pop(),
                  child: Text(l10n.groupPlannerCancel),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _busy ? null : _save,
                  child: _busy
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.commonSave),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
