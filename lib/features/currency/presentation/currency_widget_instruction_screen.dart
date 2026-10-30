import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_widget/home_widget.dart';

import '../../../l10n/l10n_helpers.dart';
import '../../../services/widget_service.dart';

String _currencyColorToHex(Color c) {
  final a = ((c.a * 255.0).round()).clamp(0, 255);
  final r = ((c.r * 255.0).round()).clamp(0, 255);
  final g = ((c.g * 255.0).round()).clamp(0, 255);
  final b = ((c.b * 255.0).round()).clamp(0, 255);
  final v = ((a & 0xff) << 24) | ((r & 0xff) << 16) | ((g & 0xff) << 8) | (b & 0xff);
  return v.toRadixString(16).padLeft(8, '0');
}

Color? _currencyParseColorHex(String? raw) {
  if (raw == null) return null;
  final t = raw.trim();
  if (t.isEmpty || t.toLowerCase() == 'auto') return null;
  var h = t;
  if (h.startsWith('#')) h = h.substring(1);
  final v = int.tryParse(h, radix: 16);
  if (v == null) return null;
  if (h.length <= 6) return Color(0xFF000000 | v);
  return Color(v);
}

const List<Color?> kCurrencyTextColorPresets = <Color?>[
  null,
  Color(0xFFFFFFFF),
  Color(0xFFD4AF37),
  Color(0xFF5EEAD4),
  Color(0xFFFFB74D),
  Color(0xFFCFD8DC),
];

const List<Color?> kCurrencyBackgroundPresets = <Color?>[
  null,
  Color(0xFF0B132B),
  Color(0xFF1A237E),
  Color(0xFF004D40),
  Color(0xFF3E2723),
  Color(0xFF212121),
  Color(0xFF4A148C),
];

/// How to add / style the currency converter home + lock-screen widget.
class CurrencyWidgetInstructionScreen extends StatefulWidget {
  const CurrencyWidgetInstructionScreen({super.key});

  @override
  State<CurrencyWidgetInstructionScreen> createState() =>
      _CurrencyWidgetInstructionScreenState();
}

class _CurrencyWidgetInstructionScreenState
    extends State<CurrencyWidgetInstructionScreen> {
  bool _pinning = false;
  bool _loadingStyle = true;
  bool _savingStyle = false;

  double _fontScale = 1.0;
  Color? _primaryColor;
  Color? _secondaryColor;
  Color? _captionColor;
  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    _loadStyle();
  }

  Future<void> _loadStyle() async {
    if (kIsWeb || !(Platform.isIOS || Platform.isAndroid)) {
      if (mounted) setState(() => _loadingStyle = false);
      return;
    }
    final fsRaw = await HomeWidget.getWidgetData<String>(
      CurrencyWidgetKeys.fontScale,
      defaultValue: '1.0',
    );
    final primaryHex = await HomeWidget.getWidgetData<String>(
      CurrencyWidgetKeys.primaryColorHex,
      defaultValue: 'auto',
    );
    final secondaryHex = await HomeWidget.getWidgetData<String>(
      CurrencyWidgetKeys.secondaryColorHex,
      defaultValue: 'auto',
    );
    final captionHex = await HomeWidget.getWidgetData<String>(
      CurrencyWidgetKeys.captionColorHex,
      defaultValue: 'auto',
    );
    final bgHex = await HomeWidget.getWidgetData<String>(
      CurrencyWidgetKeys.backgroundColorHex,
      defaultValue: 'auto',
    );
    if (!mounted) return;
    final parsedFs = double.tryParse(fsRaw ?? '1.0') ?? 1.0;
    setState(() {
      _fontScale = parsedFs.clamp(0.78, 2.0);
      _primaryColor = _currencyParseColorHex(primaryHex);
      _secondaryColor = _currencyParseColorHex(secondaryHex);
      _captionColor = _currencyParseColorHex(captionHex);
      _backgroundColor = _currencyParseColorHex(bgHex);
      _loadingStyle = false;
    });
  }

  Future<void> _saveStyle() async {
    setState(() => _savingStyle = true);
    try {
      await WidgetService.saveCurrencyWidgetStyleAndRefresh(
        fontScale: _fontScale,
        primaryColorHex:
            _primaryColor == null ? 'auto' : _currencyColorToHex(_primaryColor!),
        secondaryColorHex: _secondaryColor == null
            ? 'auto'
            : _currencyColorToHex(_secondaryColor!),
        captionColorHex:
            _captionColor == null ? 'auto' : _currencyColorToHex(_captionColor!),
        backgroundColorHex: _backgroundColor == null
            ? 'auto'
            : _currencyColorToHex(_backgroundColor!),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.currencyWidgetAppearanceSaved)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.currencyWidgetAppearanceSaveFailed)),
      );
    } finally {
      if (mounted) setState(() => _savingStyle = false);
    }
  }

  Future<void> _addWidgetToHomeScreen() async {
    if (kIsWeb || !Platform.isAndroid) return;
    setState(() => _pinning = true);
    try {
      final supported = await HomeWidget.isRequestPinWidgetSupported();
      if (!mounted) return;
      if (supported != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.currencyWidgetPinUnsupported)),
        );
        return;
      }
      await HomeWidget.requestPinWidget(
        qualifiedAndroidName: 'com.tripmetic.app.CurrencyWidgetProvider',
      );
      await WidgetService.seedAndroidCurrencyWidget();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.currencyWidgetPinFailed)),
      );
    } finally {
      if (mounted) setState(() => _pinning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final showPinButton = !kIsWeb && Platform.isAndroid;
    final showAppearance = !kIsWeb && (Platform.isIOS || Platform.isAndroid);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.primaryContainer.withValues(alpha: 0.5),
                      border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
                    ),
                    child: Icon(Icons.currency_exchange_rounded, size: 48, color: cs.primary),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.currencyWidgetInstructionTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.currencyWidgetInstructionSubtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 24),
                _InstructionSection(
                  title: l10n.currencyWidgetInstructionAndroidTitle,
                  steps: [
                    l10n.currencyWidgetInstructionAndroidStep1,
                    l10n.currencyWidgetInstructionAndroidStep2,
                    l10n.currencyWidgetInstructionAndroidStep3,
                    l10n.currencyWidgetInstructionAndroidStep4,
                  ],
                ),
                const SizedBox(height: 28),
                _InstructionSection(
                  title: l10n.currencyWidgetInstructionUsageTitle,
                  steps: [
                    l10n.currencyWidgetInstructionUsageStep1,
                    l10n.currencyWidgetInstructionUsageStep2,
                    l10n.currencyWidgetInstructionUsageStep3,
                  ],
                ),
                if (!kIsWeb && Platform.isIOS) ...[
                  const SizedBox(height: 28),
                  _InstructionSection(
                    title: l10n.currencyWidgetInstructionIosTitle,
                    steps: [
                      l10n.currencyWidgetInstructionIosHint,
                    ],
                  ),
                ],
                if (showAppearance) ...[
                  const SizedBox(height: 32),
                  Text(
                    l10n.currencyWidgetAppearanceTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.currencyWidgetAppearanceHint,
                    style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  if (_loadingStyle)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else ...[
                    Row(
                      children: [
                        Expanded(child: Text(l10n.currencyWidgetFontScaleLabel)),
                        Text(
                          '${(_fontScale * 100).round()}%',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _fontScale,
                      min: 0.78,
                      max: 2.0,
                      divisions: 15,
                      label: '${(_fontScale * 100).round()}%',
                      onChanged: (v) => setState(() => _fontScale = v),
                    ),
                    const SizedBox(height: 8),
                    _CurrencyColorRow(
                      label: l10n.currencyWidgetColorPrimary,
                      selected: _primaryColor,
                      presets: kCurrencyTextColorPresets,
                      onChanged: (c) => setState(() => _primaryColor = c),
                    ),
                    const SizedBox(height: 12),
                    _CurrencyColorRow(
                      label: l10n.currencyWidgetColorAccent,
                      selected: _secondaryColor,
                      presets: kCurrencyTextColorPresets,
                      onChanged: (c) => setState(() => _secondaryColor = c),
                    ),
                    const SizedBox(height: 12),
                    _CurrencyColorRow(
                      label: l10n.currencyWidgetColorCaption,
                      selected: _captionColor,
                      presets: kCurrencyTextColorPresets,
                      onChanged: (c) => setState(() => _captionColor = c),
                    ),
                    const SizedBox(height: 12),
                    _CurrencyColorRow(
                      label: l10n.currencyWidgetColorBackground,
                      selected: _backgroundColor,
                      presets: kCurrencyBackgroundPresets,
                      onChanged: (c) => setState(() => _backgroundColor = c),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _savingStyle ? null : _saveStyle,
                      child: _savingStyle
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.currencyWidgetSaveAppearance),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
        Material(
          elevation: 8,
          color: theme.scaffoldBackgroundColor,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showPinButton)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: OutlinedButton(
                        onPressed: _pinning ? null : _addWidgetToHomeScreen,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: cs.primary.withValues(alpha: 0.6)),
                        ),
                        child: _pinning
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: cs.primary,
                                ),
                              )
                            : Text(l10n.currencyWidgetInstructionPinCta),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.push('/currency-widget/select'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                      ),
                      child: Text(l10n.currencyWidgetInstructionOpenCurrencyCta),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencyColorRow extends StatelessWidget {
  const _CurrencyColorRow({
    required this.label,
    required this.selected,
    required this.presets,
    required this.onChanged,
  });

  final String label;
  final Color? selected;
  final List<Color?> presets;
  final ValueChanged<Color?> onChanged;

  bool _matchesPreset(Color? preset) {
    if (preset == null && selected == null) return true;
    if (preset == null || selected == null) return false;
    return _currencyColorToHex(preset) == _currencyColorToHex(selected!);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final preset in presets)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => onChanged(preset),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _matchesPreset(preset) ? cs.primary : cs.outlineVariant,
                        width: _matchesPreset(preset) ? 2.5 : 1,
                      ),
                      color: preset ?? cs.surfaceContainerHighest,
                    ),
                    child: preset == null
                        ? Icon(
                            Icons.auto_awesome_rounded,
                            size: 18,
                            color: cs.onSurfaceVariant,
                          )
                        : null,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _InstructionSection extends StatelessWidget {
  const _InstructionSection({
    required this.steps,
    this.title,
  });

  final String? title;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.primary,
            ),
          ),
          const SizedBox(height: 12),
        ],
        ...List.generate(steps.length, (i) {
          return Padding(
            padding: EdgeInsets.only(bottom: i < steps.length - 1 ? 14 : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: cs.primary.withValues(alpha: 0.15),
                  foregroundColor: cs.primary,
                  child: Text(
                    '${i + 1}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    steps[i],
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
