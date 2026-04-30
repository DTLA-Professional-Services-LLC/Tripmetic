import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sealed_currencies/sealed_currencies.dart';

import '../../currency/application/currency_providers.dart';
import '../../currency/domain/exchange_rate_snapshot.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../application/trip_providers.dart';
import '../domain/trip_budget.dart';
import '../domain/trip_budget_category_icons.dart';
import 'budget_destination_country_picker.dart';

/// Financial dashboard palette (bento): navy canvas, slate tiles, electric blue + gold accents.
const _kCanvas = AppColors.background;
const _kBentoSurface = Color(0xFF1E293B);
const _kBentoBorder = Color(0xFF334155);
const _kInputFill = Color(0xFF293548);
const _kInputBorder = Color(0xFF475569);
const _kMuted = Color(0xFF94A3B8);
const _kFieldRadius = 12.0;
const _kInputMaxWidth = 148.0;

/// Multi-destination trip budget with selectable base currency.
class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen> {
  late final TextEditingController _totalController;
  final _totalFocus = FocusNode();
  late Map<String, TextEditingController> _expenseControllers;
  late final TextEditingController _tripDaysController;
  final _tripDaysFocus = FocusNode();

  /// Local category order used during editing. Empty when not editing.
  /// Category changes (add/rename/remove) are purely local and only
  /// committed to the provider when the user taps "Save budget".
  List<String> _editingCategoryKeys = [];

  /// Categories that were removed during the current editing session.
  /// Their keys are tracked so _saveBudget can call removeCategory.
  final Set<String> _removedCategories = {};

  static final List<String> _allFiatCodes =
      FiatCurrency.listExtended.map((f) => f.code).toSet().toList()..sort();

  static String _fmtBase(double v, String code) {
    if (v.isNaN || v.isInfinite) return '—';
    return '${NumberFormat('#,##0.00').format(v)} $code';
  }

  static final NumberFormat _moneyDisplay = NumberFormat('#,##0.##');
  static final NumberFormat _intDisplay = NumberFormat('#,##0');

  static String _displayMoney(double v) {
    if (v == 0) return '';
    return _moneyDisplay.format(v);
  }

  static String _displayTripDays(int days) {
    return _intDisplay.format(days);
  }

  /// Numeric part only (for stacked destination labels).
  static String _formatDestNumber(double v, String code) {
    final fiat = FiatCurrency.maybeFromCode(code);
    final zeroDecimals = fiat?.subunitToUnit == 1;
    final fmt = zeroDecimals ? NumberFormat('#,##0', 'en_US') : NumberFormat('#,##0.00', 'en_US');
    final n = zeroDecimals ? v.round().toDouble() : v;
    return fmt.format(n);
  }

  @override
  void initState() {
    super.initState();
    final b = ref.read(tripBudgetProvider);
    _totalController = TextEditingController(text: _displayMoney(b.totalBudget));
    _tripDaysController = TextEditingController(text: _displayTripDays(b.tripDays));
    _expenseControllers = {};
    for (final k in b.categoryKeys) {
      if (k == TripBudgetExpenseKeys.dailyFood) {
        _expenseControllers[k] = TextEditingController(text: _displayMoney(b.dailyFoodTotal));
      } else {
        _expenseControllers[k] = TextEditingController(text: _displayMoney(b.expenses[k] ?? 0));
      }
    }
  }

  void _syncControllersFromProvider() {
    final b = ref.read(tripBudgetProvider);
    _totalController.text = _displayMoney(b.totalBudget);
    _tripDaysController.text = _displayTripDays(b.tripDays);
    // Create / update controllers for current categories
    for (final k in b.categoryKeys) {
      final display = k == TripBudgetExpenseKeys.dailyFood
          ? _displayMoney(b.dailyFoodTotal)
          : _displayMoney(b.expenses[k] ?? 0);
      if (_expenseControllers.containsKey(k)) {
        _expenseControllers[k]!.text = display;
      } else {
        _expenseControllers[k] = TextEditingController(text: display);
      }
    }
  }

  /// The category keys to display — uses local editing list when editing,
  /// or the provider's keys when in read-only mode.
  List<String> get _displayCategoryKeys {
    if (_editing && _editingCategoryKeys.isNotEmpty) {
      return _editingCategoryKeys;
    }
    return ref.read(tripBudgetProvider).categoryKeys;
  }

  @override
  void dispose() {
    _totalController.dispose();
    _totalFocus.dispose();
    _tripDaysController.dispose();
    _tripDaysFocus.dispose();
    for (final c in _expenseControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  double? _parseMoney(String raw) {
    final s = raw.trim().replaceAll(',', '').replaceAll(RegExp(r'[$€£¥]'), '');
    if (s.isEmpty) return 0;
    return double.tryParse(s);
  }

  int? _parseInt(String raw) {
    final s = raw.trim().replaceAll(',', '');
    if (s.isEmpty) return null;
    return int.tryParse(s);
  }

  bool _editing = false;

  Future<void> _saveBudget() async {
    final n = ref.read(tripBudgetProvider.notifier);
    final total = _parseMoney(_totalController.text) ?? 0;
    await n.setTotalBudget(total);
    final daysRaw = _parseInt(_tripDaysController.text);
    if (daysRaw != null && daysRaw > 0) {
      await n.setTripDays(daysRaw);
    }
    // Remove categories that the user deleted during this edit session.
    for (final cat in _removedCategories) {
      await n.removeCategory(cat);
    }
    // Save all current categories (includes newly added + renamed ones).
    for (final cat in _editingCategoryKeys) {
      final ctrl = _expenseControllers[cat];
      if (ctrl == null) continue;
      final v = _parseMoney(ctrl.text) ?? 0;
      await n.setExpense(cat, v);
    }
    if (!mounted) return;
    _editingCategoryKeys = [];
    _removedCategories.clear();
    setState(() => _editing = false);
    _syncControllersFromProvider();
  }

  void _startEditing() {
    final b = ref.read(tripBudgetProvider);
    _syncControllersFromProvider();
    setState(() {
      _editing = true;
      _editingCategoryKeys = List<String>.from(b.categoryKeys);
      _removedCategories.clear();
    });
  }

  void _cancelEditing() {
    // Remove controllers for categories added during this session. They don't
    // exist in the provider so _syncControllersFromProvider won't recreate them.
    // Defer disposal to post-frame so any TextFormField detaches first.
    final providerKeys = ref.read(tripBudgetProvider).categoryKeys.toSet();
    final addedDuringEdit = _editingCategoryKeys.where((k) => !providerKeys.contains(k)).toList();
    final toDispose = <TextEditingController>[];
    for (final k in addedDuringEdit) {
      final c = _expenseControllers.remove(k);
      if (c != null) toDispose.add(c);
    }
    _editingCategoryKeys = [];
    _removedCategories.clear();
    _syncControllersFromProvider();
    setState(() => _editing = false);
    if (toDispose.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (final c in toDispose) {
          c.dispose();
        }
      });
    }
  }

  Future<void> _promptAddCategory() async {
    final l10n = context.l10n;
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => _CategoryDialog(
        title: l10n.budgetDialogNewCategory,
        confirmLabel: l10n.budgetDialogAdd,
        existingNames: _editingCategoryKeys.toSet(),
      ),
    );
    if (result == null || result.trim().isEmpty || !mounted) return;
    final name = result.trim();
    // Purely local: create controller + add to local list, no provider mutation.
    _expenseControllers[name] = TextEditingController(text: '');
    setState(() {
      _editingCategoryKeys.add(name);
    });
  }

  Future<void> _promptRenameCategory(String oldName) async {
    final l10n = context.l10n;
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => _CategoryDialog(
        title: l10n.budgetDialogRenameCategory,
        initialName: oldName,
        confirmLabel: l10n.budgetDialogRename,
        existingNames: _editingCategoryKeys.where((k) => k != oldName).toSet(),
      ),
    );
    if (result == null || result.trim().isEmpty || !mounted) return;
    final newName = result.trim();
    if (newName == oldName) return;
    // Purely local: move controller + update local list, no provider mutation.
    final ctrl = _expenseControllers.remove(oldName);
    _expenseControllers[newName] = ctrl ?? TextEditingController(text: '');
    // Track the old name for removal on save (if it was a provider category).
    final providerKeys = ref.read(tripBudgetProvider).expenses.keys.toSet();
    if (providerKeys.contains(oldName)) {
      _removedCategories.add(oldName);
    }
    setState(() {
      final idx = _editingCategoryKeys.indexOf(oldName);
      if (idx >= 0) {
        _editingCategoryKeys[idx] = newName;
      } else {
        _editingCategoryKeys.add(newName);
      }
    });
  }

  Future<void> _promptRemoveCategory(String name) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _kBentoSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: _kBentoBorder),
        ),
        title: Text(l10n.budgetDialogRemoveTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        content: Text(
          l10n.budgetDialogRemoveBody(name),
          style: const TextStyle(color: _kMuted, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel, style: const TextStyle(color: _kMuted)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonRemove),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    // Remove from map so the rebuild skips this row, but defer disposal
    // until after the frame so the TextFormField detaches first.
    final removedCtrl = _expenseControllers.remove(name);
    if (removedCtrl != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => removedCtrl.dispose());
    }
    final providerKeys = ref.read(tripBudgetProvider).expenses.keys.toSet();
    if (providerKeys.contains(name)) {
      _removedCategories.add(name);
    }
    setState(() {
      _editingCategoryKeys.remove(name);
    });
  }

  Future<void> _promptAddDestination() async {
    final code = await showBudgetDestinationCountryPicker(context);
    if (code == null || !mounted) return;
    await ref.read(tripBudgetProvider.notifier).addDestinationCurrency(code);
  }

  InputDecoration _fieldDeco(ThemeData theme, String? hint) {
    final r = BorderRadius.circular(_kFieldRadius);
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: _kInputFill,
      isDense: true,
      hintStyle: const TextStyle(color: _kMuted, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(borderRadius: r, borderSide: const BorderSide(color: _kInputBorder)),
      enabledBorder: OutlineInputBorder(borderRadius: r, borderSide: const BorderSide(color: _kInputBorder)),
      focusedBorder: OutlineInputBorder(
        borderRadius: r,
        borderSide: BorderSide(color: _editing ? AppColors.accent : _kInputBorder, width: _editing ? 1.5 : 1),
      ),
      disabledBorder: OutlineInputBorder(borderRadius: r, borderSide: BorderSide(color: _kMuted.withValues(alpha: 0.35))),
    );
  }

  TextStyle get _inputTextStyle => const TextStyle(
        color: Color(0xFFF1F5F9),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );

  @override
  Widget build(BuildContext context) {
    final budget = ref.watch(tripBudgetProvider);
    final ratesAsync = ref.watch(exchangeRatesStreamProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final base = budget.baseCurrency;

    ref.listen(tripBudgetProvider, (prev, next) {
      if (_editing) return;
      _syncControllersFromProvider();
    });

    final spent = budget.totalSpent;
    final remaining = budget.remaining;
    final total = budget.totalBudget <= 0 ? 1.0 : budget.totalBudget;
    final progress = (spent / total).clamp(0.0, 1.0);
    final snap = ratesAsync.valueOrNull ?? ExchangeRateSnapshot.defaults();
    final menuCodes = List<String>.from(_allFiatCodes);
    if (!menuCodes.contains(base)) {
      menuCodes.add(base);
      menuCodes.sort();
    }

    final titleStyle = theme.textTheme.titleSmall?.copyWith(
      color: const Color(0xFFF1F5F9),
      fontWeight: FontWeight.w700,
    );

    return ColoredBox(
      color: _kCanvas,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n.budgetTripTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.budgetTripDashboard,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent.withValues(alpha: 0.95),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                children: [
                  _SummaryBentoCard(
                    remaining: remaining,
                    base: base,
                    snap: snap,
                    budget: budget,
                    ratesLoading: ratesAsync.isLoading,
                    editing: _editing,
                    spent: spent,
                    progress: progress,
                    onAddDestination: _promptAddDestination,
                    onRemoveDestination: (code) {
                      ref.read(tripBudgetProvider.notifier).removeDestinationCurrency(code);
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.budgetBaseCurrency,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _kMuted,
                      letterSpacing: 1.0,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _BentoShell(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: menuCodes.contains(base) ? base : menuCodes.first,
                        isExpanded: true,
                        icon: const Icon(Icons.expand_more_rounded, color: _kMuted),
                        dropdownColor: _kBentoSurface,
                        menuMaxHeight: 320,
                        style: _inputTextStyle,
                        items: menuCodes
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c, style: _inputTextStyle),
                              ),
                            )
                            .toList(),
                        onChanged: !_editing
                            ? null
                            : (c) {
                                if (c != null) {
                                  ref.read(tripBudgetProvider.notifier).setBaseCurrency(c);
                                }
                              },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.budgetTotalBudget(base),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _kMuted,
                      letterSpacing: 1.0,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _BentoShell(
                    child: TextFormField(
                      controller: _totalController,
                      focusNode: _totalFocus,
                      readOnly: !_editing,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      ],
                      style: titleStyle,
                      decoration: _fieldDeco(theme, l10n.budgetHintTotal),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _DailyFoodBentoCard(
                    editing: _editing,
                    theme: theme,
                    base: base,
                    budget: budget,
                    snap: snap,
                    tripDaysController: _tripDaysController,
                    tripDaysFocus: _tripDaysFocus,
                    foodController: _expenseControllers[TripBudgetExpenseKeys.dailyFood]!,
                    fieldDeco: _fieldDeco,
                    inputTextStyle: _inputTextStyle,
                    onFoodChanged: _editing ? () => setState(() {}) : null,
                    fmtBase: _fmtBase,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.budgetOtherExpenses(base),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _kMuted,
                            letterSpacing: 1.0,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      if (_editing)
                        GestureDetector(
                          onTap: _promptAddCategory,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_circle_outline_rounded, color: AppColors.accent, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                l10n.budgetDialogAdd,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _BentoShell(
                    padding: EdgeInsets.zero,
                    child: Builder(builder: (_) {
                      final otherKeys = _displayCategoryKeys
                          .where((k) => k != TripBudgetExpenseKeys.dailyFood)
                          .toList();
                      return Column(
                        children: [
                          for (var i = 0; i < otherKeys.length; i++) ...[
                            if (i > 0)
                              Divider(height: 1, thickness: 1, color: _kBentoBorder.withValues(alpha: 0.7)),
                            if (_expenseControllers.containsKey(otherKeys[i]))
                              _ExpenseDashboardRow(
                                key: ValueKey(otherKeys[i]),
                                category: otherKeys[i],
                                controller: _expenseControllers[otherKeys[i]]!,
                                editing: _editing,
                                baseCode: base,
                                destinationCodes: budget.destinationCurrencies,
                                snap: snap,
                                fieldDeco: _fieldDeco(theme, '0'),
                                inputTextStyle: _inputTextStyle,
                                onChanged: _editing ? (_) => setState(() {}) : null,
                                onRename: _editing ? () => _promptRenameCategory(otherKeys[i]) : null,
                                onRemove: _editing ? () => _promptRemoveCategory(otherKeys[i]) : null,
                              ),
                          ],
                          if (otherKeys.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                l10n.budgetNoCategories,
                                style: theme.textTheme.bodySmall?.copyWith(color: _kMuted),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  if (_editing)
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _kMuted,
                              side: BorderSide(color: _kBentoBorder),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: _cancelEditing,
                            child: Text(l10n.commonCancel),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.onAccent,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: _saveBudget,
                            child: Text(l10n.budgetSave),
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.onAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _startEditing,
                        child: Text(l10n.budgetEdit),
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

// —— Bento shell ————————————————————————————————————————————————————

class _BentoShell extends StatelessWidget {
  const _BentoShell({required this.child, this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 12)});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: _kBentoSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBentoBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// —— Summary bento (spending power + destinations + progress) ——————————

class _SummaryBentoCard extends StatelessWidget {
  const _SummaryBentoCard({
    required this.remaining,
    required this.base,
    required this.snap,
    required this.budget,
    required this.ratesLoading,
    required this.editing,
    required this.spent,
    required this.progress,
    required this.onAddDestination,
    required this.onRemoveDestination,
  });

  final double remaining;
  final String base;
  final ExchangeRateSnapshot snap;
  final TripBudget budget;
  final bool ratesLoading;
  final bool editing;
  final double spent;
  final double progress;
  final Future<void> Function() onAddDestination;
  final void Function(String code) onRemoveDestination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return _BentoShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.budgetSpendingPower,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _kMuted,
                        letterSpacing: 0.8,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _BudgetScreenState._fmtBase(remaining, base),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.budgetRemainingAfter(base),
                      style: theme.textTheme.labelSmall?.copyWith(color: _kMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            l10n.budgetInDestinations,
            style: theme.textTheme.labelSmall?.copyWith(
              color: _kMuted,
              letterSpacing: 0.6,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final code in budget.destinationCurrencies)
                Material(
                  color: Colors.transparent,
                  child: Chip(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: _kInputFill,
                    side: BorderSide(color: AppColors.accent.withValues(alpha: 0.45)),
                    label: Text(
                      _BudgetScreenState._fmtBase(
                        snap.convert(amountInFrom: remaining, from: base, to: code),
                        code,
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFE2E8F0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    deleteIcon: editing
                        ? Icon(Icons.close_rounded, size: 16, color: _kMuted.withValues(alpha: 0.9))
                        : null,
                    onDeleted: editing ? () => onRemoveDestination(code) : null,
                  ),
                ),
              ActionChip(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                side: BorderSide(color: AppColors.accent.withValues(alpha: 0.5)),
                avatar: Icon(Icons.add_rounded, size: 18, color: editing ? AppColors.accent : _kMuted),
                label: Text(
                  l10n.budgetDialogAdd,
                  style: TextStyle(
                    color: editing ? AppColors.accent : _kMuted,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                onPressed: editing ? () => onAddDestination() : null,
              ),
            ],
          ),
          if (ratesLoading)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  minHeight: 3,
                  backgroundColor: _kBentoBorder,
                  color: AppColors.accent,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Divider(height: 1, color: _kBentoBorder.withValues(alpha: 0.85)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.budgetSpentVsBudget,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _kMuted,
                  letterSpacing: 0.5,
                  fontSize: 11,
                ),
              ),
              Flexible(
                child: Text(
                  '${_BudgetScreenState._fmtBase(spent, base)} / ${_BudgetScreenState._fmtBase(budget.totalBudget, base)}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFE2E8F0),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: _kInputFill,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

// —— Daily food bento ——————————————————————————————————————————————————

class _DailyFoodBentoCard extends StatelessWidget {
  const _DailyFoodBentoCard({
    required this.editing,
    required this.theme,
    required this.base,
    required this.budget,
    required this.snap,
    required this.tripDaysController,
    required this.tripDaysFocus,
    required this.foodController,
    required this.fieldDeco,
    required this.inputTextStyle,
    required this.onFoodChanged,
    required this.fmtBase,
  });

  final bool editing;
  final ThemeData theme;
  final String base;
  final TripBudget budget;
  final ExchangeRateSnapshot snap;
  final TextEditingController tripDaysController;
  final FocusNode tripDaysFocus;
  final TextEditingController foodController;
  final InputDecoration Function(ThemeData theme, String? hint) fieldDeco;
  final TextStyle inputTextStyle;
  final VoidCallback? onFoodChanged;
  final String Function(double v, String code) fmtBase;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _BentoShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(tripBudgetCategoryIcon(TripBudgetExpenseKeys.dailyFood), color: AppColors.accent, size: 22),
              const SizedBox(width: 8),
              Text(
                l10n.budgetDailyFood,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 340;
              final tripField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.budgetTripLengthDays,
                    style: theme.textTheme.labelSmall?.copyWith(color: _kMuted, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: tripDaysController,
                    focusNode: tripDaysFocus,
                    readOnly: !editing,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    style: inputTextStyle,
                    decoration: fieldDeco(theme, l10n.budgetHintDays),
                  ),
                ],
              );
              final foodField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.budgetTotalForTrip(base),
                    style: theme.textTheme.labelSmall?.copyWith(color: _kMuted, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: foodController,
                    readOnly: !editing,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    style: inputTextStyle,
                    decoration: fieldDeco(theme, l10n.budgetHintZero),
                    onChanged: onFoodChanged != null ? (_) => onFoodChanged!() : null,
                  ),
                ],
              );

              final grid = wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: tripField),
                        const SizedBox(width: 12),
                        Expanded(child: foodField),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        tripField,
                        const SizedBox(height: 10),
                        foodField,
                      ],
                    );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: grid,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: _DestinationConversionsColumn(
                      amountBase: _parseMoneyForConversions(foodController.text),
                      baseCode: base,
                      destinationCodes: budget.destinationCurrencies,
                      snap: snap,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withValues(alpha: 0.18),
                  AppColors.accent.withValues(alpha: 0.08),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.45)),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_flat_rounded, color: AppColors.accent, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.budgetPerDayEstimate,
                        style: theme.textTheme.labelSmall?.copyWith(color: _kMuted, fontSize: 10),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.budgetPerDayValue(fmtBase(budget.dailyFoodPerDay, base)),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _parseMoneyForConversions(String raw) {
    final s = raw.trim().replaceAll(',', '').replaceAll(RegExp(r'[$€£¥]'), '');
    if (s.isEmpty) return 0;
    return double.tryParse(s) ?? 0;
  }
}

// —— Other expense row: left input / right conversions ————————————————————

class _ExpenseDashboardRow extends StatelessWidget {
  const _ExpenseDashboardRow({
    super.key,
    required this.category,
    required this.controller,
    required this.editing,
    required this.baseCode,
    required this.destinationCodes,
    required this.snap,
    required this.fieldDeco,
    required this.inputTextStyle,
    required this.onChanged,
    this.onRename,
    this.onRemove,
  });

  final String category;
  final TextEditingController controller;
  final bool editing;
  final String baseCode;
  final List<String> destinationCodes;
  final ExchangeRateSnapshot snap;
  final InputDecoration fieldDeco;
  final TextStyle inputTextStyle;
  final void Function(String)? onChanged;
  final VoidCallback? onRename;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final categoryLabel = tripBudgetCategoryLabel(l10n, category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Icon(tripBudgetCategoryIcon(category), color: AppColors.accent, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              categoryLabel,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: const Color(0xFFE2E8F0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (editing && (onRename != null || onRemove != null))
                            SizedBox(
                              width: 28,
                              height: 22,
                              child: PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                iconSize: 18,
                                icon: Icon(Icons.more_vert_rounded, color: _kMuted.withValues(alpha: 0.85), size: 18),
                                color: _kBentoSurface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: _kBentoBorder),
                                ),
                                onSelected: (v) {
                                  if (v == 'rename') onRename?.call();
                                  if (v == 'remove') onRemove?.call();
                                },
                                itemBuilder: (_) => [
                                  if (onRename != null)
                                    PopupMenuItem(
                                      value: 'rename',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit_rounded, color: _kMuted, size: 18),
                                          SizedBox(width: 8),
                                          Text(l10n.budgetDialogRename, style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                  if (onRemove != null)
                                    PopupMenuItem(
                                      value: 'remove',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 18),
                                          SizedBox(width: 8),
                                          Text(l10n.commonRemove, style: TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: _kInputMaxWidth,
                        child: TextFormField(
                          controller: controller,
                          readOnly: !editing,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                          ],
                          style: inputTextStyle,
                          decoration: fieldDeco,
                          onChanged: onChanged,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: _DestinationConversionsColumn(
              amountBase: _parseMoney(controller.text),
              baseCode: baseCode,
              destinationCodes: destinationCodes,
              snap: snap,
            ),
          ),
        ],
      ),
    );
  }

  double _parseMoney(String raw) {
    final s = raw.trim().replaceAll(',', '').replaceAll(RegExp(r'[\$€£¥]'), '');
    if (s.isEmpty) return 0;
    return double.tryParse(s) ?? 0;
  }
}

// —— Right-aligned stacked destination amounts ————————————————————————————

class _DestinationConversionsColumn extends StatelessWidget {
  const _DestinationConversionsColumn({
    required this.amountBase,
    required this.baseCode,
    required this.destinationCodes,
    required this.snap,
  });

  final double amountBase;
  final String baseCode;
  final List<String> destinationCodes;
  final ExchangeRateSnapshot snap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dests = destinationCodes.where((c) => c != baseCode).take(2).toList();

    const numberColor = Color(0xFFF1F5F9);
    const codeColor = Color(0xFFCBD5E1);

    if (amountBase <= 0 || dests.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          '—',
          textAlign: TextAlign.right,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: _kMuted.withValues(alpha: 0.75),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final d in dests)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: theme.textTheme.titleSmall?.copyWith(
                  color: numberColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                  letterSpacing: -0.2,
                ),
                children: [
                  TextSpan(
                    text: _BudgetScreenState._formatDestNumber(
                      snap.convert(amountInFrom: amountBase, from: baseCode, to: d),
                      d,
                    ),
                  ),
                  TextSpan(
                    text: ' ${d.toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                      color: codeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// —— Add / Rename category dialog ——————————————————————————————————————————

class _CategoryDialog extends StatefulWidget {
  const _CategoryDialog({
    required this.title,
    this.initialName = '',
    required this.confirmLabel,
    required this.existingNames,
  });

  final String title;
  final String initialName;
  final String confirmLabel;
  final Set<String> existingNames;

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  late final TextEditingController _nameController;
  bool _valid = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _validate(_nameController.text);
    _nameController.addListener(_onInput);
  }

  void _onInput() => _validate(_nameController.text);

  void _validate(String raw) {
    final l10n = context.l10n;
    final trimmed = raw.trim();
    String? err;
    bool ok = trimmed.isNotEmpty;
    if (trimmed.isEmpty) {
      err = null; // don't nag on empty
      ok = false;
    } else if (widget.existingNames.contains(trimmed)) {
      err = l10n.budgetCategoryNameExists;
      ok = false;
    } else if (trimmed.length > 40) {
      err = l10n.budgetCategoryNameMax;
      ok = false;
    }
    if (mounted) setState(() { _valid = ok; _error = err; });
  }

  @override
  void dispose() {
    _nameController.removeListener(_onInput);
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      backgroundColor: _kBentoSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: _kBentoBorder),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            autofocus: true,
            maxLength: 40,
            style: const TextStyle(color: Color(0xFFF1F5F9), fontSize: 14, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: l10n.budgetCategoryDialogHint,
              hintStyle: const TextStyle(color: _kMuted, fontSize: 13),
              filled: true,
              fillColor: _kInputFill,
              counterStyle: const TextStyle(color: _kMuted, fontSize: 10),
              errorText: _error,
              errorStyle: const TextStyle(fontSize: 11),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _kInputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _kInputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.accent, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            onSubmitted: _valid ? (_) => Navigator.pop(context, _nameController.text.trim()) : null,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel, style: const TextStyle(color: _kMuted)),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: _valid ? AppColors.accent : _kBentoBorder,
            foregroundColor: _valid ? AppColors.onAccent : _kMuted,
          ),
          onPressed: _valid ? () => Navigator.pop(context, _nameController.text.trim()) : null,
          child: Text(widget.confirmLabel),
        ),
      ],
    );
  }
}
