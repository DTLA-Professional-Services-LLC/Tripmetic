import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_widget/home_widget.dart';

import '../../../l10n/l10n_helpers.dart';
import '../application/dual_clock_widget_service.dart';
import '../data/dual_city_presets.dart';
import '../domain/dual_city_preset.dart';
import '../domain/dual_clock_widget_keys.dart';

String _dualClockColorToHex(Color c) {
  final a = ((c.a * 255.0).round()).clamp(0, 255);
  final r = ((c.r * 255.0).round()).clamp(0, 255);
  final g = ((c.g * 255.0).round()).clamp(0, 255);
  final b = ((c.b * 255.0).round()).clamp(0, 255);
  final v = ((a & 0xff) << 24) | ((r & 0xff) << 16) | ((g & 0xff) << 8) | (b & 0xff);
  return v.toRadixString(16).padLeft(8, '0');
}

Color? _dualClockParseColorHex(String? raw) {
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

/// First chip is Auto (null); rest are fixed presets for lock-screen legibility.
const List<Color?> kDualClockColorPresets = <Color?>[
  null,
  Color(0xFFFFFFFF),
  Color(0xFFD4AF37),
  Color(0xFF5EEAD4),
  Color(0xFFFFB74D),
  Color(0xFFCFD8DC),
];

class DualCitySelectionScreen extends StatefulWidget {
  const DualCitySelectionScreen({super.key});

  @override
  State<DualCitySelectionScreen> createState() => _DualCitySelectionScreenState();
}

class _DualCitySelectionScreenState extends State<DualCitySelectionScreen> {
  bool _loading = true;
  bool _saving = false;

  DualCityPreset? _city1;
  DualCityPreset? _city2;

  double _fontScale = 1.0;
  Color? _cityColor;
  Color? _timeColor;
  Color? _dateColor;
  bool _useTextShadow = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final d1 = kDualClockDefaultCity1;
    final d2 = kDualClockDefaultCity2;
    final c1 = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.city1Name,
      defaultValue: d1.label,
    );
    final z1 = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.city1Tz,
      defaultValue: d1.timezoneId,
    );
    final c2 = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.city2Name,
      defaultValue: d2.label,
    );
    final z2 = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.city2Tz,
      defaultValue: d2.timezoneId,
    );
    final fsRaw = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.fontScale,
      defaultValue: '1.0',
    );
    final cityHex = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.cityColorHex,
      defaultValue: 'auto',
    );
    final timeHex = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.timeColorHex,
      defaultValue: 'auto',
    );
    final dateHex = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.dateColorHex,
      defaultValue: 'auto',
    );
    final shadowRaw = await HomeWidget.getWidgetData<String>(
      DualClockWidgetKeys.useTextShadow,
      defaultValue: '1',
    );

    if (!mounted) return;

    final parsedFs = double.tryParse(fsRaw ?? '1.0') ?? 1.0;

    setState(() {
      _city1 = _presetOrStored(c1, z1, kDualClockDefaultCity1);
      _city2 = _presetOrStored(c2, z2, kDualClockDefaultCity2);
      _fontScale = parsedFs.clamp(0.78, 1.55);
      _cityColor = _dualClockParseColorHex(cityHex);
      _timeColor = _dualClockParseColorHex(timeHex);
      _dateColor = _dualClockParseColorHex(dateHex);
      _useTextShadow =
          (shadowRaw ?? '1') != '0' && (shadowRaw ?? '1').toLowerCase() != 'false';
      _loading = false;
    });
  }

  DualCityPreset _presetOrStored(
    String? name,
    String? tz,
    DualCityPreset defaults,
  ) {
    if (name != null && tz != null) {
      for (final p in kDualCityPresets) {
        if (p.label == name && p.timezoneId == tz) return p;
      }
      return DualCityPreset(label: name, timezoneId: tz);
    }
    return defaults;
  }

  List<DualCityPreset> _dropdownItems(DualCityPreset current) {
    final list = List<DualCityPreset>.from(kDualCityPresets);
    final exists =
        list.any((e) => e.label == current.label && e.timezoneId == current.timezoneId);
    if (!exists) list.insert(0, current);
    return list;
  }

  Future<void> _save() async {
    final p1 = _city1;
    final p2 = _city2;
    if (p1 == null || p2 == null) return;

    setState(() => _saving = true);
    try {
      await DualClockWidgetService.saveAndRefresh(
        city1Name: p1.label,
        city1Tz: p1.timezoneId,
        city2Name: p2.label,
        city2Tz: p2.timezoneId,
        fontScale: _fontScale,
        cityColorHex: _cityColor == null ? 'auto' : _dualClockColorToHex(_cityColor!),
        timeColorHex: _timeColor == null ? 'auto' : _dualClockColorToHex(_timeColor!),
        dateColorHex: _dateColor == null ? 'auto' : _dualClockColorToHex(_dateColor!),
        useTextShadow: _useTextShadow,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.dualClockSaved)),
      );
      if (mounted) context.pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.dualClockSaveError)),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (_loading || _city1 == null || _city2 == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    final p1 = _city1!;
    final p2 = _city2!;

    return LayoutBuilder(
      builder: (context, _) {
        final itemH = (MediaQuery.sizeOf(context).shortestSide * 0.19).clamp(64.0, 80.0);
        final menuMaxH = MediaQuery.sizeOf(context).height * 0.45;
        final fieldMinH = (MediaQuery.sizeOf(context).shortestSide * 0.16).clamp(52.0, 68.0);

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.dualClockConfigSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              _CityTimezoneDropdown(
                label: l10n.dualClockCity1Label,
                value: p1,
                items: _dropdownItems(p1),
                fieldMinHeight: fieldMinH,
                menuItemHeight: itemH,
                menuMaxHeight: menuMaxH,
                onChanged: (v) {
                  if (v != null) setState(() => _city1 = v);
                },
              ),
              const SizedBox(height: 20),
              _CityTimezoneDropdown(
                label: l10n.dualClockCity2Label,
                value: p2,
                items: _dropdownItems(p2),
                fieldMinHeight: fieldMinH,
                menuItemHeight: itemH,
                menuMaxHeight: menuMaxH,
                onChanged: (v) {
                  if (v != null) setState(() => _city2 = v);
                },
              ),
              const SizedBox(height: 24),
              Text(
                l10n.dualClockAppearanceTitle,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.dualClockAppearanceHint,
                style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text(l10n.dualClockFontScaleLabel)),
                  Text(
                    '${(_fontScale * 100).round()}%',
                    style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Slider(
                value: _fontScale,
                min: 0.78,
                max: 1.55,
                divisions: 15,
                label: '${(_fontScale * 100).round()}%',
                onChanged: (v) => setState(() => _fontScale = v),
              ),
              const SizedBox(height: 8),
              _DualClockColorRow(
                label: l10n.dualClockColorCity,
                selected: _cityColor,
                onChanged: (c) => setState(() => _cityColor = c),
              ),
              const SizedBox(height: 12),
              _DualClockColorRow(
                label: l10n.dualClockColorTime,
                selected: _timeColor,
                onChanged: (c) => setState(() => _timeColor = c),
              ),
              const SizedBox(height: 12),
              _DualClockColorRow(
                label: l10n.dualClockColorDate,
                selected: _dateColor,
                onChanged: (c) => setState(() => _dateColor = c),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.dualClockShadowLabel),
                subtitle: Text(
                  l10n.dualClockShadowSubtitle,
                  style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                value: _useTextShadow,
                onChanged: (v) => setState(() => _useTextShadow = v),
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.dualClockSave),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DualClockColorRow extends StatelessWidget {
  const _DualClockColorRow({
    required this.label,
    required this.selected,
    required this.onChanged,
  });

  final String label;
  final Color? selected;
  final ValueChanged<Color?> onChanged;

  bool _matchesPreset(Color? preset) {
    if (preset == null && selected == null) return true;
    if (preset == null || selected == null) return false;
    return _dualClockColorToHex(preset) == _dualClockColorToHex(selected!);
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
            for (final preset in kDualClockColorPresets)
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

class _CityTimezoneDropdown extends StatelessWidget {
  const _CityTimezoneDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.fieldMinHeight,
    required this.menuItemHeight,
    required this.menuMaxHeight,
  });

  final String label;
  final DualCityPreset value;
  final List<DualCityPreset> items;
  final ValueChanged<DualCityPreset?> onChanged;
  final double fieldMinHeight;
  final double menuItemHeight;
  final double menuMaxHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final labelStyle = theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600);
    final fieldPrimary = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 14,
      height: 1.22,
      fontWeight: FontWeight.w600,
    );
    final fieldSecondary = theme.textTheme.bodySmall?.copyWith(
      fontSize: 12,
      height: 1.2,
      color: cs.onSurfaceVariant,
      fontWeight: FontWeight.w400,
    );
    final menuCityStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 13,
      height: 1.2,
      fontWeight: FontWeight.w600,
    );
    final menuTzStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 11.5,
      height: 1.15,
      color: cs.onSurfaceVariant,
      fontWeight: FontWeight.w400,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 8),
        InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsetsDirectional.only(start: 14, end: 10, top: 12, bottom: 12),
            isDense: false,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: fieldMinHeight),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DualCityPreset>(
                value: value,
                isExpanded: true,
                borderRadius: BorderRadius.circular(12),
                menuMaxHeight: menuMaxHeight,
                itemHeight: menuItemHeight,
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: cs.onSurfaceVariant),
                style: fieldPrimary,
                selectedItemBuilder: (context) {
                  return items.map((e) {
                    return Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: fieldPrimary,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            e.timezoneId,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: fieldSecondary,
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
                items: items
                    .map(
                      (e) => DropdownMenuItem<DualCityPreset>(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                e.label,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: menuCityStyle,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                e.timezoneId,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: menuTzStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
