import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../application/group_planner_providers.dart';
import '../domain/trip_budget_type.dart';

/// Form to create a Firestore-backed group trip, then open its dashboard.
class GroupPlannerCreateTripScreen extends ConsumerStatefulWidget {
  const GroupPlannerCreateTripScreen({super.key});

  @override
  ConsumerState<GroupPlannerCreateTripScreen> createState() =>
      _GroupPlannerCreateTripScreenState();
}

class _GroupPlannerCreateTripScreenState
    extends ConsumerState<GroupPlannerCreateTripScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _destination;
  late final TextEditingController _groupSize;
  late final TextEditingController _budgetAmount;

  DateTime? _start;
  DateTime? _end;
  TripBudgetType _budgetType = TripBudgetType.none;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _destination = TextEditingController();
    _groupSize = TextEditingController(text: '4');
    _budgetAmount = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _destination.dispose();
    _groupSize.dispose();
    _budgetAmount.dispose();
    super.dispose();
  }

  Future<void> _pickDates(AppLocalizations l10n) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var startDay = _start ?? today;
    var endDay = _end ?? startDay.add(const Duration(days: 7));
    if (endDay.isBefore(startDay)) endDay = startDay;

    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: startDay, end: endDay),
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

  Future<void> _submit(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;
    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.groupPlannerCreateTripSignInRequired),
          action: SnackBarAction(
            label: l10n.bucketListSignIn,
            onPressed: () => context.push('/sign-in'),
          ),
        ),
      );
      return;
    }
    if (_start == null || _end == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.groupPlannerSelectDates)),
      );
      return;
    }
    if (_end!.isBefore(_start!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListValidationDates)),
      );
      return;
    }

    final gs = int.tryParse(_groupSize.text.trim()) ?? 0;
    final rawBudget = _budgetAmount.text.trim();
    final ba = rawBudget.isEmpty ? 0.0 : (double.tryParse(rawBudget) ?? 0.0);

    setState(() => _busy = true);
    try {
      final result = await ref.read(groupTripServiceProvider).createTrip(
            destination: _destination.text.trim(),
            startDate: _start!,
            endDate: _end!,
            groupSize: gs,
            budgetType: _budgetType,
            budgetAmount: ba,
          );
      if (!mounted) return;
      context.pushReplacement('/group-trip/${result.inviteCode}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _budgetTypeLabel(AppLocalizations l10n, TripBudgetType t) {
    return switch (t) {
      TripBudgetType.perPerson => l10n.groupPlannerBudgetPerPersonOption,
      TripBudgetType.group => l10n.groupPlannerBudgetGroupOption,
      TripBudgetType.none => l10n.groupPlannerBudgetNoneOption,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isPro = ref.watch(isTripmeticProProvider);
    final dateFmt = DateFormat.yMMMd();

    final dateLabel = _start != null && _end != null
        ? '${dateFmt.format(_start!)} – ${dateFmt.format(_end!)}'
        : l10n.groupPlannerDates;

    return ProGlassOverlay(
      featureId: NavFeatureIds.groupPlanner,
      isPro: isPro,
      child: Stack(
        children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _destination,
                  decoration: InputDecoration(
                    labelText: l10n.groupPlannerDestination,
                    border: const OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l10n.bucketListValidationRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _busy ? null : () => _pickDates(l10n),
                  icon: const Icon(Icons.date_range_rounded),
                  label: Text(dateLabel),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _groupSize,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.groupPlannerGroupSize,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final n = int.tryParse(v?.trim() ?? '');
                    if (n == null || n < 1) {
                      return l10n.bucketListValidationNumber;
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: _budgetAmount,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.groupPlannerBudgetAmountLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _busy ? null : () => _submit(l10n),
                  child: Text(l10n.groupPlannerLandingPlanTitle),
                ),
              ],
            ),
          ),
        ),
        if (_busy)
          const Positioned.fill(
            child: IgnorePointer(
              child: ModalBarrier(dismissible: false, color: Colors.black26),
            ),
          ),
          if (_busy)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
