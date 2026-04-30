import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/l10n_helpers.dart';
import '../domain/unit_category.dart';
import '../domain/unit_conversion.dart';

class UnitsTab extends StatefulWidget {
  const UnitsTab({super.key});

  @override
  State<UnitsTab> createState() => _UnitsTabState();
}

class _UnitsTabState extends State<UnitsTab> {
  UnitCategory _category = UnitCategory.length;
  late List<UnitRow> _rows;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool _suppress = false;

  @override
  void initState() {
    super.initState();
    _rows = unitsForCategory(_category);
    _controllers = List.generate(_rows.length, (_) => TextEditingController());
    _focusNodes = List.generate(_rows.length, (_) => FocusNode());
    _attachSelectAllOnFocus();
    _seedDefaults();
  }

  /// When a value field is focused, select the whole number so the user can
  /// type a replacement without manually clearing the field.
  void _attachSelectAllOnFocus() {
    for (var i = 0; i < _focusNodes.length; i++) {
      final idx = i;
      _focusNodes[idx].addListener(() {
        if (!_focusNodes[idx].hasFocus) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted || !_focusNodes[idx].hasFocus) return;
          final t = _controllers[idx].text;
          _controllers[idx].selection = TextSelection(baseOffset: 0, extentOffset: t.length);
        });
      });
    }
  }

  void _seedDefaults() {
    _suppress = true;
    if (_category == UnitCategory.temperature) {
      _controllers[0].text = '32';
      _controllers[1].text = '0';
    } else {
      final canonical = switch (_category) {
        UnitCategory.length => 1.0,
        UnitCategory.weight => 1.0,
        UnitCategory.volume => 1.0,
        UnitCategory.distance => 1.0,
        UnitCategory.area => 1.0,
        UnitCategory.temperature => 0.0,
      };
      for (var i = 0; i < _rows.length; i++) {
        final id = _rows[i].id;
        final v = UnitConversion.fromCanonical(_category, id, canonical);
        _controllers[i].text = UnitConversion.formatValue(_category, id, v);
      }
    }
    _suppress = false;
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

  void _onCategorySelected(UnitCategory c) {
    if (c == _category) return;
    for (final x in _controllers) {
      x.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    setState(() {
      _category = c;
      _rows = unitsForCategory(c);
      _controllers = List.generate(_rows.length, (_) => TextEditingController());
      _focusNodes = List.generate(_rows.length, (_) => FocusNode());
      _attachSelectAllOnFocus();
      _seedDefaults();
    });
  }

  void _applyFromIndex(int editedIndex, String text) {
    if (_suppress) return;
    final parsed = parseUnitInput(text);
    if (parsed == null) return;
    final id = _rows[editedIndex].id;
    final canonical = UnitConversion.toCanonical(_category, id, parsed);
    _suppress = true;
    for (var i = 0; i < _rows.length; i++) {
      if (i == editedIndex) continue;
      final oid = _rows[i].id;
      final v = UnitConversion.fromCanonical(_category, oid, canonical);
      _controllers[i].text = UnitConversion.formatValue(_category, oid, v);
    }
    _suppress = false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              context.l10n.unitsHeader,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final c in UnitCategory.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(unitCategoryTitle(context.l10n, c)),
                        selected: _category == c,
                        onSelected: (_) => _onCategorySelected(c),
                        selectedColor: cs.primary.withValues(alpha: 0.25),
                        checkmarkColor: cs.primary,
                        labelStyle: TextStyle(
                          color: _category == c ? cs.primary : cs.onSurfaceVariant,
                          fontWeight: _category == c ? FontWeight.w600 : FontWeight.w400,
                        ),
                        side: BorderSide(
                          color: _category == c ? cs.primary : cs.outline,
                        ),
                        backgroundColor: cs.surface,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: _rows.length,
              itemBuilder: (context, index) {
                final row = _rows[index];
                final isFirst = index == 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _UnitCard(
                    row: row,
                    label: unitRowLabel(context.l10n, row.id),
                    isHighlight: isFirst,
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (t) => _applyFromIndex(index, t),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitCard extends StatelessWidget {
  const _UnitCard({
    required this.row,
    required this.label,
    required this.isHighlight,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final UnitRow row;
  final String label;
  final bool isHighlight;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final border = Border.all(
      color: isHighlight ? cs.primary.withValues(alpha: 0.85) : cs.outline,
      width: isHighlight ? 1.6 : 1,
    );
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: border,
          boxShadow: isHighlight
              ? [
                  BoxShadow(
                    color: cs.primary.withValues(alpha: 0.1),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$label (${row.symbol})',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    row.symbol,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 18,
                          color: cs.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 140,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                textInputAction: TextInputAction.done,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]'))],
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 26,
                      color: isHighlight ? cs.primary : cs.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: onChanged,
                onSubmitted: (_) => focusNode.unfocus(),
                onTapOutside: (_) => focusNode.unfocus(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
