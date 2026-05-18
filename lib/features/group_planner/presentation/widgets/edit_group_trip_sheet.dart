import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/l10n_helpers.dart';
import '../../application/group_planner_providers.dart';
import '../../application/group_trip_service.dart';
import '../../domain/group_trip.dart';
import '../../domain/trip_budget_type.dart';

Future<void> showEditGroupTripSheet({
  required BuildContext context,
  required GroupTrip trip,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(ctx).bottom,
        ),
        child: _EditGroupTripSheetBody(trip: trip),
      );
    },
  );
}

class _EditGroupTripSheetBody extends ConsumerStatefulWidget {
  const _EditGroupTripSheetBody({required this.trip});

  final GroupTrip trip;

  @override
  ConsumerState<_EditGroupTripSheetBody> createState() =>
      _EditGroupTripSheetBodyState();
}

class _EditGroupTripSheetBodyState extends ConsumerState<_EditGroupTripSheetBody> {
  late final TextEditingController _destCtrl;
  late final TextEditingController _groupSizeCtrl;
  late final TextEditingController _budgetCtrl;
  late DateTime _start;
  late DateTime _end;
  late TripBudgetType _budgetType;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    final t = widget.trip;
    _destCtrl = TextEditingController(text: t.destination);
    _groupSizeCtrl = TextEditingController(text: '${t.groupSize}');
    _budgetCtrl = TextEditingController(
      text: t.budgetAmount == 0 ? '' : '${t.budgetAmount}',
    );
    _start = DateTime(t.startDate.year, t.startDate.month, t.startDate.day);
    _end = DateTime(t.endDate.year, t.endDate.month, t.endDate.day);
    _budgetType = t.budgetType;
  }

  @override
  void dispose() {
    _destCtrl.dispose();
    _groupSizeCtrl.dispose();
    _budgetCtrl.dispose();
    super.dispose();
  }

  String _budgetTypeLabel(AppLocalizations l10n, TripBudgetType t) =>
      switch (t) {
        TripBudgetType.perPerson => l10n.groupPlannerBudgetPerPersonOption,
        TripBudgetType.group => l10n.groupPlannerBudgetGroupOption,
        TripBudgetType.none => l10n.groupPlannerBudgetNoneOption,
      };

  Future<void> _pickDates() async {
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: _start, end: _end),
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      builder: (ctx, child) {
        final theme = Theme.of(ctx);
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(primary: AppColors.accent),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked == null || !mounted) return;
    setState(() {
      _start = DateTime(picked.start.year, picked.start.month, picked.start.day);
      _end = DateTime(picked.end.year, picked.end.month, picked.end.day);
    });
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final gs = int.tryParse(_groupSizeCtrl.text.trim()) ?? 0;
    if (gs < 1) return;
    if (_destCtrl.text.trim().isEmpty) return;
    if (_end.isBefore(_start)) return;
    final rawB = _budgetCtrl.text.trim();
    final ba = rawB.isEmpty ? 0.0 : (double.tryParse(rawB) ?? 0.0);

    setState(() => _busy = true);
    try {
      await ref.read(groupTripServiceProvider).updateTrip(
            tripId: widget.trip.id,
            destination: _destCtrl.text,
            startDate: _start,
            endDate: _end,
            groupSize: gs,
            budgetType: _budgetType,
            budgetAmount: ba,
          );
      ref.invalidate(myGroupTripsStreamProvider);
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
          SnackBar(content: Text(l10n.groupPlannerTripUpdateError('$e'))),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final dateFmt = DateFormat.yMMMd();
    final dateLabel = '${dateFmt.format(_start)} – ${dateFmt.format(_end)}';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.groupPlannerEditTripTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _destCtrl,
            enabled: !_busy,
            decoration: InputDecoration(
              labelText: l10n.groupPlannerDestination,
              border: const OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _busy ? null : _pickDates,
            icon: const Icon(Icons.date_range_rounded),
            label: Text(dateLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _groupSizeCtrl,
            enabled: !_busy,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.groupPlannerGroupSize,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<TripBudgetType>(
            initialValue: _budgetType,
            decoration: InputDecoration(
              labelText: l10n.groupPlannerBudget,
              border: const OutlineInputBorder(),
            ),
            items: TripBudgetType.values
                .map(
                  (t) => DropdownMenuItem(
                    value: t,
                    child: Text(_budgetTypeLabel(l10n, t)),
                  ),
                )
                .toList(),
            onChanged: _busy
                ? null
                : (v) {
                    if (v != null) setState(() => _budgetType = v);
                  },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _budgetCtrl,
            enabled: !_busy,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.groupPlannerBudgetAmountLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _busy ? null : _save,
            child: _busy
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
