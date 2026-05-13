import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_widget/home_widget.dart';

import '../../../l10n/l10n_helpers.dart';
import '../application/dual_clock_widget_service.dart';
import '../data/dual_city_presets.dart';
import '../domain/dual_city_preset.dart';
import '../domain/dual_clock_widget_keys.dart';

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

    if (!mounted) return;

    setState(() {
      _city1 = _presetOrStored(c1, z1, kDualClockDefaultCity1);
      _city2 = _presetOrStored(c2, z2, kDualClockDefaultCity2);
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
          Text(
            l10n.dualClockCity1Label,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsetsDirectional.only(start: 12, end: 8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DualCityPreset>(
                value: p1,
                isExpanded: true,
                items: _dropdownItems(p1)
                    .map(
                      (e) => DropdownMenuItem<DualCityPreset>(
                        value: e,
                        child: Text('${e.label} (${e.timezoneId})'),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _city1 = v);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.dualClockCity2Label,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsetsDirectional.only(start: 12, end: 8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DualCityPreset>(
                value: p2,
                isExpanded: true,
                items: _dropdownItems(p2)
                    .map(
                      (e) => DropdownMenuItem<DualCityPreset>(
                        value: e,
                        child: Text('${e.label} (${e.timezoneId})'),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _city2 = v);
                },
              ),
            ),
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
  }
}
