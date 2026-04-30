import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sealed_currencies/sealed_currencies.dart';

import '../../../l10n/l10n_helpers.dart';
import '../application/currency_providers.dart';
import '../application/exchange_calculator.dart';
import '../data/currency_repository.dart';
import '../domain/exchange_rate_snapshot.dart';
import 'currency_flag.dart';
import 'widgets/currency_picker_sheet.dart';

class CurrencyTab extends ConsumerStatefulWidget {
  const CurrencyTab({super.key});

  @override
  ConsumerState<CurrencyTab> createState() => _CurrencyTabState();
}

class _CurrencyTabState extends ConsumerState<CurrencyTab> {
  static const _slotCount = 6;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  late List<String> _codes;
  double _usdAmount = 1;
  bool _suppress = false;

  @override
  void initState() {
    super.initState();
    _codes = List<String>.from(kDefaultCurrencySelection);
    _controllers = List.generate(_slotCount, (_) => TextEditingController());
    _focusNodes = List.generate(_slotCount, (_) => FocusNode());
    for (var i = 0; i < _slotCount; i++) {
      final idx = i;
      _focusNodes[idx].addListener(() {
        if (_focusNodes[idx].hasFocus) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted || !_focusNodes[idx].hasFocus) return;
            final t = _controllers[idx].text;
            _controllers[idx].selection = TextSelection(baseOffset: 0, extentOffset: t.length);
          });
        } else {
          _onFieldBlur();
        }
      });
    }
    Future<void>.microtask(_loadPrefs);
  }

  Future<void> _loadPrefs() async {
    final repo = ref.read(currencyRepositoryProvider);
    final sel = repo.readSelection();
    final amt = repo.readUsdAmount();
    if (!mounted) return;
    setState(() {
      if (sel != null) {
        _codes = sel;
      }
      if (amt != null && amt > 0) {
        _usdAmount = amt;
      }
    });
    final snap = ref.read(exchangeRatesStreamProvider).asData?.value;
    if (snap != null && mounted) {
      _applyUsd(snap, _usdAmount);
    }
  }

  Future<void> _persistAmount() async {
    await ref.read(currencyRepositoryProvider).saveUsdAmount(_usdAmount);
  }

  Future<void> _persistSelection() async {
    await ref.read(currencyRepositoryProvider).saveSelection(_codes);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _applyUsd(ExchangeRateSnapshot snap, double usd, {int? exceptIndex}) {
    _usdAmount = usd;
    _suppress = true;
    for (var i = 0; i < _slotCount; i++) {
      if (exceptIndex != null && i == exceptIndex && _focusNodes[i].hasFocus) {
        continue;
      }
      final code = _codes[i];
      final fiat = fiatCurrencyOrUsd(code);
      final v = amountFromUsd(snap, code, usd);
      _controllers[i].text = formatForCurrency(v, fiat);
    }
    _suppress = false;
  }

  void _onFieldBlur() {
    final snap = ref.read(exchangeRatesStreamProvider).asData?.value;
    if (snap == null || !mounted) return;
    _applyUsd(snap, _usdAmount);
    _persistAmount();
  }

  void _onFieldChanged(int index, ExchangeRateSnapshot snap, String text) {
    if (_suppress) return;
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      _applyUsd(snap, 0, exceptIndex: index);
      _persistAmount();
      return;
    }
    final parsed = parseAmountInput(text);
    if (parsed == null) return;
    final code = _codes[index];
    final usd = usdFromAmount(snap, code, parsed);
    _applyUsd(snap, usd, exceptIndex: index);
    _persistAmount();
  }

  void _resetTo(ExchangeRateSnapshot snap, double usd) {
    FocusScope.of(context).unfocus();
    setState(() {
      _applyUsd(snap, usd);
    });
    _persistAmount();
  }

  Future<void> _pickCurrency(int index, ExchangeRateSnapshot snap) async {
    final excluded = {
      for (var j = 0; j < _slotCount; j++)
        if (j != index) _codes[j],
    };
    final picked = await showCurrencyPickerSheet(
      context,
      selectedCode: _codes[index],
      excludedCodes: excluded,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _codes[index] = picked;
    });
    await _persistSelection();
    _applyUsd(snap, _usdAmount);
    await _persistAmount();
  }

  @override
  Widget build(BuildContext context) {
    final ratesAsync = ref.watch(exchangeRatesStreamProvider);

    ref.listen<AsyncValue<ExchangeRateSnapshot>>(exchangeRatesStreamProvider, (prev, next) {
      next.whenData((snap) {
        _applyUsd(snap, _usdAmount);
      });
    });

    return ratesAsync.when(
      loading: () => Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)),
      error: (e, st) => Center(
        child: Text(
          context.l10n.exchangeCouldNotLoad(e.toString()),
          textAlign: TextAlign.center,
        ),
      ),
      data: (snap) {
        final updated = snap.updatedAt.toLocal();
        final mins = DateTime.now().difference(updated).inMinutes.clamp(0, 1 << 30);
        final theme = Theme.of(context);
        final cs = theme.colorScheme;
        final l10n = context.l10n;
        final minsStr = mins.toString();

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      l10n.exchangeHeader,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    tooltip: l10n.exchangeResetTooltip,
                    icon: Icon(Icons.refresh_rounded, color: cs.primary, size: 22),
                    onSelected: (v) {
                      if (v == 'one') {
                        _resetTo(snap, 1);
                      } else if (v == 'zero') {
                        _resetTo(snap, 0);
                      }
                    },
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        value: 'one',
                        child: Text(l10n.exchangeResetOne),
                      ),
                      PopupMenuItem(
                        value: 'zero',
                        child: Text(l10n.exchangeResetZero),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                  ),
                  Expanded(
                    child: Text(
                      snap.isOffline
                          ? l10n.exchangeLastUpdatedOffline(minsStr)
                          : l10n.exchangeLastUpdated(minsStr),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.primary.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < _slotCount; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: _CurrencyCard(
                    fiat: fiatCurrencyOrUsd(_codes[i]),
                    flagEmoji: flagEmojiForCurrency(fiatCurrencyOrUsd(_codes[i])),
                    isBase: i == 0,
                    baseSuffix: l10n.exchangeBaseSuffix,
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    onChanged: (t) => _onFieldChanged(i, snap, t),
                    onPickCurrency: () => _pickCurrency(i, snap),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CurrencyCard extends StatelessWidget {
  const _CurrencyCard({
    required this.fiat,
    required this.flagEmoji,
    required this.isBase,
    required this.baseSuffix,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onPickCurrency,
  });

  final FiatCurrency fiat;
  final String flagEmoji;
  final bool isBase;
  final String baseSuffix;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onPickCurrency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final labelStyle = theme.textTheme.labelMedium;
    final valueStyle = theme.textTheme.titleLarge?.copyWith(
      fontSize: isBase ? 26 : 21,
      color: isBase ? cs.primary : cs.onSurface,
      fontWeight: FontWeight.w700,
    );

    final border = Border.all(
      color: isBase ? cs.primary.withValues(alpha: 0.75) : cs.outline,
      width: isBase ? 1.4 : 1,
    );

    final sym = fiat.symbol ?? fiat.code;

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: border,
          boxShadow: isBase
              ? [
                  BoxShadow(
                    color: cs.primary.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPickCurrency,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  child: Row(
                    children: [
                      Text(
                        flagEmoji,
                        style: const TextStyle(fontSize: 20, height: 1.1),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${fiat.code} · ${fiat.name}${isBase ? baseSuffix : ''}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: labelStyle?.copyWith(height: 1.15),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded, color: cs.primary, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  sym,
                  style: labelStyle?.copyWith(fontSize: 14, color: cs.onSurfaceVariant),
                ),
                const Spacer(),
                SizedBox(
                  width: isBase ? 150 : 128,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                    textInputAction: TextInputAction.done,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                    textAlign: TextAlign.right,
                    style: valueStyle,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: onChanged,
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
