import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../application/tip_calculator_notifier.dart';
import '../application/tip_calculator_state.dart';
import '../domain/tip_amount_format.dart';

class TipCalculatorScreen extends ConsumerStatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  ConsumerState<TipCalculatorScreen> createState() =>
      _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends ConsumerState<TipCalculatorScreen> {
  late final TextEditingController _billController;
  late final TextEditingController _tipController;
  final _billFocus = FocusNode();
  final _tipFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _billController = TextEditingController();
    _tipController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final s = ref.read(tipCalculatorProvider);
      _tipController.text = _formatTipPercent(s.tipPercent);
    });
  }

  @override
  void dispose() {
    _billController.dispose();
    _tipController.dispose();
    _billFocus.dispose();
    _tipFocus.dispose();
    super.dispose();
  }

  void _formatBillFieldOnBlur() {
    final n = ref.read(tipCalculatorProvider.notifier);
    final s = ref.read(tipCalculatorProvider);
    final v = parseBillInput(_billController.text);
    if (v == null) {
      _billController.text = s.billAmount == 0
          ? ''
          : formatUsdAmount(s.billAmount);
      return;
    }
    n.setBillAmount(v);
    _billController.text = v == 0 ? '' : formatUsdAmount(v);
  }

  static String _formatTipPercent(double v) {
    if (v == v.roundToDouble()) return v.round().toString();
    return v.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(tipCalculatorProvider);
    final n = ref.read(tipCalculatorProvider.notifier);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final isPro = ref.watch(isTripmeticProProvider);
    final zeroReason = tipCountryZeroReason(l10n, s.country);

    ref.listen(tipCalculatorProvider, (prev, next) {
      if (prev?.tipPercent != next.tipPercent && !_tipFocus.hasFocus) {
        _tipController.text = _formatTipPercent(next.tipPercent);
      }
    });

    return ProGlassOverlay(
      featureId: NavFeatureIds.tipCalculator,
      isPro: isPro,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
        children: [
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.tipCurrentCountry,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: cs.surface,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<TipCountry>(
                      value: s.country,
                      isExpanded: true,
                      isDense: true,
                      dropdownColor: cs.surface,
                      borderRadius: BorderRadius.circular(12),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: cs.primary,
                        size: 22,
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface,
                      ),
                      items: TipCountry.values
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                '${tipCountryLabel(l10n, c)} (${c.defaultTipPercent.toStringAsFixed(0)}%)',
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (c) {
                        if (c != null) n.setCountry(c);
                      },
                    ),
                  ),
                ),
                if (zeroReason != null) ...[
                  const SizedBox(height: 8),
                  _ZeroTipNote(
                    title: l10n.tipZeroReasonTitle,
                    body: zeroReason,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.tipTotalBill,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) _formatBillFieldOnBlur();
                  },
                  child: TextField(
                    controller: _billController,
                    focusNode: _billFocus,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,$]')),
                    ],
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.tipBillHint,
                      isDense: true,
                      hintStyle: TextStyle(
                        color: cs.onSurfaceVariant.withValues(alpha: 0.6),
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: cs.surface,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (t) {
                      if (t.trim().isEmpty) {
                        n.setBillAmount(0);
                        return;
                      }
                      final v = parseBillInput(t);
                      if (v != null) n.setBillAmount(v);
                    },
                    onEditingComplete: _formatBillFieldOnBlur,
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      l10n.tipPercentLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_formatTipPercent(s.tipPercent)}%',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                _TipPercentField(
                  hintText: l10n.tipPercentHint,
                  controller: _tipController,
                  focusNode: _tipFocus,
                  onChanged: (t) {
                    final raw = t.trim().replaceAll(',', '');
                    if (raw.isEmpty) {
                      n.setTipPercent(0);
                      return;
                    }
                    final v = double.tryParse(raw);
                    if (v != null) n.setTipPercent(v);
                  },
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                  ),
                  child: Slider(
                    value: s.tipPercent.round().clamp(0, 100).toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${s.tipPercent.round().clamp(0, 100)}%',
                    onChanged: (v) {
                      final whole = v.round().clamp(0, 100).toDouble();
                      n.setTipPercent(whole);
                      _tipController.text = _formatTipPercent(whole);
                    },
                  ),
                ),
                Row(
                  children: [
                    Text(
                      l10n.tipPeople,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${s.people}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                  ),
                  child: Slider(
                    value: s.people.toDouble(),
                    min: 1,
                    max: 20,
                    divisions: 19,
                    label: '${s.people}',
                    onChanged: (v) => n.setPeople(v.round()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _ResultsPanel(s: s, l10n: l10n),
        ],
      ),
    );
  }
}

class _ZeroTipNote extends StatelessWidget {
  const _ZeroTipNote({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cs.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipPercentField extends StatelessWidget {
  const _TipPercentField({
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
      style: theme.textTheme.titleSmall?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        hintStyle: TextStyle(
          color: cs.onSurfaceVariant.withValues(alpha: 0.6),
          fontSize: 14,
        ),
        suffixText: '%',
        suffixStyle: theme.textTheme.titleSmall?.copyWith(
          color: cs.primary,
          fontWeight: FontWeight.w700,
        ),
        filled: true,
        fillColor: cs.surface,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      onChanged: onChanged,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
      ),
      child: child,
    );
  }
}

class _ResultsPanel extends StatelessWidget {
  const _ResultsPanel({required this.s, required this.l10n});

  final TipCalculatorState s;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.primary.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.tipResults,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          _ResultLine(
            label: l10n.tipAmount,
            value: formatUsdAmount(s.tipAmount),
            large: false,
          ),
          const SizedBox(height: 6),
          _ResultLine(
            label: l10n.tipTotalWithTip,
            value: formatUsdAmount(s.totalWithTip),
            large: true,
          ),
          const SizedBox(height: 6),
          _ResultLine(
            label: l10n.tipPerPerson,
            value: formatUsdAmount(s.amountPerPerson),
            large: true,
          ),
        ],
      ),
    );
  }
}

class _ResultLine extends StatelessWidget {
  const _ResultLine({
    required this.label,
    required this.value,
    required this.large,
  });

  final String label;
  final String value;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: large
              ? theme.textTheme.titleLarge?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w800,
                )
              : theme.textTheme.titleSmall?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
        ),
      ],
    );
  }
}
