import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sealed_currencies/sealed_currencies.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../services/widget_service.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
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
  bool _ratesRefreshing = false;
  bool _openedWidgetPicker = false;
  bool _widgetRatesRefreshed = false;
  bool _widgetRefreshHandled = false;
  bool _prefsLoaded = false;

  /// Free-tier entry points for the Android home-screen widget only.
  bool get _widgetFreeAccess {
    final path = GoRouterState.of(context).uri.path;
    return path == '/currency-widget/select' || path == '/currency-widget/refresh';
  }

  bool get _fromWidgetCurrencySelect =>
      GoRouterState.of(context).uri.path == '/currency-widget/select';

  bool get _fromWidgetCurrencyRefresh =>
      GoRouterState.of(context).uri.path == '/currency-widget/refresh';

  /// Which converter slot to edit when opened from the home-screen widget (0 = base, 1 = target).
  int get _widgetPickerSlot {
    final slotRaw = GoRouterState.of(context).uri.queryParameters['slot'];
    final slot = int.tryParse(slotRaw ?? '1') ?? 1;
    return slot.clamp(0, _slotCount - 1);
  }

  Future<void> _refreshRatesFromWidgetEntry() async {
    final repo = ref.read(currencyRepositoryProvider);
    WidgetService.resetWidgetSyncCache();
    await WidgetService.refreshAndSyncFromRepository(repo: repo);
    if (!mounted) return;
    final snap = repo.tryPersistedSnapshot() ??
        ref.read(exchangeRatesStreamProvider).asData?.value;
    if (snap != null) {
      _applyUsd(snap, _usdAmount);
    }
  }

  Future<void> _syncHomeWidget() {
    final repo = ref.read(currencyRepositoryProvider);
    final snap = repo.tryPersistedSnapshot() ??
        ref.read(exchangeRatesStreamProvider).asData?.value ??
        _ratesSnapshotOrFallback();
    return WidgetService.syncFromCurrencyState(
      snapshot: snap,
      codes: List<String>.from(_codes),
      usdAmount: _usdAmount,
    );
  }

  Future<void> _finishWidgetFreeFlow() async {
    if (!mounted) return;
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/');
  }

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
      _prefsLoaded = true;
    });

    final snap = ref.read(exchangeRatesStreamProvider).asData?.value;
    if (snap != null && mounted) {
      _applyUsd(snap, _usdAmount);
      await _syncHomeWidget();
    }
    _maybeOpenWidgetCurrencyPicker();
  }

  /// Opens the target-currency picker when launched from the home-screen widget.
  /// Waits for saved prefs so a late [_loadPrefs] cannot overwrite the pick.
  ExchangeRateSnapshot _ratesSnapshotOrFallback() {
    return ref.read(exchangeRatesStreamProvider).asData?.value ??
        ref.read(currencyRepositoryProvider).tryPersistedSnapshot() ??
        ref.read(currencyRepositoryProvider).currentSnapshot();
  }

  Future<void> _alignCodesWithWidgetPrefs() async {
    if (!_fromWidgetCurrencySelect) return;
    final pair = await WidgetService.readWidgetCurrencyPair(
      repo: ref.read(currencyRepositoryProvider),
    );
    if (!mounted) return;
    setState(() {
      _codes[0] = pair.base;
      _codes[1] = pair.target;
      if (pair.baseAmount > 0) {
        _usdAmount = usdFromAmount(
          _ratesSnapshotOrFallback(),
          pair.base,
          pair.baseAmount,
        );
      }
    });
  }

  void _maybeOpenWidgetCurrencyPicker() {
    if (_openedWidgetPicker || !_prefsLoaded || !_fromWidgetCurrencySelect) {
      return;
    }
    final snap = _ratesSnapshotOrFallback();
    final slot = _widgetPickerSlot;

    _openedWidgetPicker = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _alignCodesWithWidgetPrefs();
      if (!mounted) return;
      await _pickCurrency(slot, snap, fromHomeScreenWidget: true);
    });
  }

  Future<void> _handleWidgetRefreshOnly() async {
    if (_widgetRefreshHandled || !_fromWidgetCurrencyRefresh) return;
    _widgetRefreshHandled = true;
    await _refreshRatesFromWidgetEntry();
    await _finishWidgetFreeFlow();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_widgetRatesRefreshed && _widgetFreeAccess) {
      _widgetRatesRefreshed = true;
      if (_fromWidgetCurrencyRefresh) {
        unawaited(_handleWidgetRefreshOnly());
      } else {
        unawaited(_refreshRatesFromWidgetEntry());
      }
    }
    _maybeOpenWidgetCurrencyPicker();
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
    _syncHomeWidget();
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
    _syncHomeWidget();
  }

  void _resetTo(ExchangeRateSnapshot snap, double usd) {
    FocusScope.of(context).unfocus();
    setState(() {
      _applyUsd(snap, usd);
    });
    _persistAmount();
    _syncHomeWidget();
  }

  Future<void> _pickCurrency(
    int index,
    ExchangeRateSnapshot snap, {
    bool fromHomeScreenWidget = false,
  }) async {
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
    WidgetService.resetWidgetSyncCache();
    await _persistSelection();
    if (fromHomeScreenWidget) {
      final repo = ref.read(currencyRepositoryProvider);
      ExchangeRateSnapshot snap = _ratesSnapshotOrFallback();
      try {
        final fresh = await repo.refreshFromNetwork();
        if (fresh != null) snap = fresh;
      } catch (_) {}
      if (!mounted) return;
      final baseAmount = amountFromUsd(snap, _codes[0], _usdAmount);
      await WidgetService.syncWidgetPair(
        snapshot: snap,
        baseCode: _codes[0],
        targetCode: _codes[1],
        baseAmountValue: baseAmount,
      );
      if (!mounted) return;
      _applyUsd(snap, _usdAmount);
      await _persistAmount();
      await _finishWidgetFreeFlow();
      return;
    }
    _applyUsd(snap, _usdAmount);
    await _persistAmount();
    await _syncHomeWidget();
  }

  @override
  Widget build(BuildContext context) {
    final ratesAsync = ref.watch(exchangeRatesStreamProvider);
    final isPro = ref.watch(isTripmeticProProvider);

    ref.listen<AsyncValue<ExchangeRateSnapshot>>(exchangeRatesStreamProvider, (prev, next) {
      next.whenData((snap) {
        if (!_widgetFreeAccess) {
          _applyUsd(snap, _usdAmount);
          _syncHomeWidget();
        }
        _maybeOpenWidgetCurrencyPicker();
      });
    });

    if (_widgetFreeAccess) {
      return const Center(child: CircularProgressIndicator());
    }

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

        return ProGlassOverlay(
          featureId: NavFeatureIds.currency,
          isPro: isPro,
          child: SafeArea(
            child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: RefreshIndicator(
              onRefresh: () async {
                WidgetService.resetWidgetSyncCache();
                await refreshExchangeRatesClearingCache(ref);
                await _syncHomeWidget();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  IconButton(
                    tooltip: l10n.exchangeRatesForceRefreshTooltip,
                    onPressed: _ratesRefreshing
                        ? null
                        : () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final okMsg = l10n.exchangeRatesRefreshedOk;
                            final failMsg = l10n.exchangeRatesRefreshFailed;
                            setState(() => _ratesRefreshing = true);
                            try {
                              WidgetService.resetWidgetSyncCache();
                              final refreshed =
                                  await refreshExchangeRatesClearingCache(ref);
                              if (!mounted) return;
                              if (refreshed == null) {
                                messenger.showSnackBar(
                                  SnackBar(content: Text(failMsg)),
                                );
                                return;
                              }
                              await _syncHomeWidget();
                              messenger.showSnackBar(
                                SnackBar(content: Text(okMsg)),
                              );
                            } catch (_) {
                              if (!mounted) return;
                              messenger.showSnackBar(
                                SnackBar(content: Text(failMsg)),
                              );
                            } finally {
                              if (mounted) setState(() => _ratesRefreshing = false);
                            }
                          },
                    icon: _ratesRefreshing
                        ? SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: cs.primary,
                            ),
                          )
                        : Icon(Icons.sync_rounded, color: cs.primary, size: 22),
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
            ),
          ),
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
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      sym,
                      style: labelStyle?.copyWith(fontSize: 14, color: cs.onSurfaceVariant),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
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
