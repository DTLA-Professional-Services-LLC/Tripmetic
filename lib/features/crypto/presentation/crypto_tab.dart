import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n_helpers.dart';
import '../application/crypto_providers.dart';
import '../data/crypto_catalog.dart';
import '../domain/crypto_format.dart';
import '../domain/crypto_rates_snapshot.dart';
import 'widgets/crypto_picker_sheet.dart';

class CryptoTab extends ConsumerStatefulWidget {
  const CryptoTab({super.key});

  @override
  ConsumerState<CryptoTab> createState() => _CryptoTabState();
}

class _CryptoTabState extends ConsumerState<CryptoTab> {
  static const _slotCount = 6;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late List<String> _codes;

  /// Internal anchor: total USD value across the row (same instant for all slots).
  double _anchorUsd = 1;
  bool _suppress = false;

  @override
  void initState() {
    super.initState();
    _codes = [
      normalizeCryptoCode('USD'),
      normalizeCryptoCode('BTC'),
      normalizeCryptoCode('ETH'),
      normalizeCryptoCode('SOL'),
      normalizeCryptoCode('BNB'),
      normalizeCryptoCode('XRP'),
    ];
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _applyAll(ref.read(cryptoUsdPerCoinProvider));
    });
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

  void _onFieldBlur() {
    if (!mounted) return;
    final snap = ref.read(cryptoRatesStreamProvider).valueOrNull;
    _applyAll(snap?.rates ?? ref.read(cryptoUsdPerCoinProvider));
  }

  void _applyAll(Map<String, double> rates, {int? exceptIndex}) {
    _suppress = true;
    for (var i = 0; i < _slotCount; i++) {
      if (exceptIndex != null && i == exceptIndex && _focusNodes[i].hasFocus) {
        continue;
      }
      final code = _codes[i];
      final amt = coinAmountFromUsd(code, _anchorUsd, rates);
      _controllers[i].text = formatAmountForCode(code, amt, rates);
    }
    _suppress = false;
  }

  void _onFieldChanged(int index, Map<String, double> rates, String text) {
    if (_suppress) return;
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      _anchorUsd = 0;
      _applyAll(rates, exceptIndex: index);
      return;
    }
    final parsed = parseAmountLoose(text);
    if (parsed == null) return;
    _anchorUsd = usdFromCoinAmount(_codes[index], parsed, rates);
    _applyAll(rates, exceptIndex: index);
  }

  Future<void> _pickCrypto(int index, CryptoRatesSnapshot snap) async {
    final rates = snap.rates;
    final excluded = {
      for (var j = 0; j < _slotCount; j++)
        if (j != index) _codes[j],
    };
    final picked = await showCryptoPickerSheet(
      context,
      selectedCode: _codes[index],
      excludedCodes: excluded,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _codes[index] = normalizeCryptoCode(picked);
    });
    _applyAll(rates);
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(cryptoRatesStreamProvider).valueOrNull ??
        CryptoRatesSnapshot(
          rates: ref.watch(cryptoUsdPerCoinProvider),
          updatedAt: DateTime.now().toUtc(),
          isOffline: true,
        );
    final rates = snap.rates;

    ref.listen(cryptoRatesStreamProvider, (prev, next) {
      next.whenData((s) {
        if (mounted) _applyAll(s.rates);
      });
    });

    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final updated = snap.updatedAt.toLocal();
    final mins = DateTime.now().difference(updated).inMinutes.clamp(0, 1 << 30);
    final l10n = context.l10n;
    final minsStr = mins.toString();
    final statusText = snap.isOffline
        ? l10n.exchangeLastUpdatedOffline(minsStr)
        : l10n.exchangeLastUpdated(minsStr);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  l10n.cryptoHeader,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                    ),
                    Flexible(
                      child: Text(
                        statusText,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: cs.primary.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < _slotCount; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == _slotCount - 1 ? 0 : 6),
              child: _CryptoCard(
                code: _codes[i],
                name: lookupCryptoAsset(_codes[i])?.name ?? _codes[i],
                isBase: i == 0,
                baseSuffix: l10n.exchangeBaseSuffix,
                controller: _controllers[i],
                focusNode: _focusNodes[i],
                onChanged: (t) => _onFieldChanged(i, rates, t),
                onPick: () => _pickCrypto(i, snap),
              ),
            ),
        ],
      ),
    );
  }
}

class _CryptoCard extends StatelessWidget {
  const _CryptoCard({
    required this.code,
    required this.name,
    required this.isBase,
    required this.baseSuffix,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onPick,
  });

  final String code;
  final String name;
  final bool isBase;
  final String baseSuffix;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final border = Border.all(
      color: isBase ? cs.primary.withValues(alpha: 0.75) : cs.outline,
      width: isBase ? 1.4 : 1,
    );
    final prefix = _symbolFor(code);
    final theme = Theme.of(context);

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
                onTap: onPick,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  child: Row(
                    children: [
                      Icon(
                        code == 'USD' ? Icons.attach_money : Icons.currency_bitcoin,
                        size: 18,
                        color: cs.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '$code · $name${isBase ? baseSuffix : ''}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(height: 1.15),
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
                  prefix,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 14,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: isBase ? 150 : 130,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                    textInputAction: TextInputAction.done,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                    textAlign: TextAlign.right,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: isBase ? 26 : 21,
                      color: isBase ? cs.primary : cs.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
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

String _symbolFor(String code) {
  return switch (code) {
    'USD' => r'$',
    'BTC' => '₿',
    'ETH' => 'Ξ',
    'SOL' => '◎',
    'BNB' => 'BNB',
    'XRP' => 'XRP',
    'DOGE' => 'Ð',
    'LTC' => 'Ł',
    'ADA' => '₳',
    _ => code.length <= 5 ? code : '${code.substring(0, 4)}…',
  };
}
