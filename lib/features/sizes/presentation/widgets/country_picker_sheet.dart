import 'package:flutter/material.dart';

import '../../../../core/geo/excluded_regions.dart';
import '../../../../l10n/l10n_helpers.dart';
import '../../domain/country_sizing_generated.dart';
import '../../domain/size_input_column.dart';

/// Searchable list of all countries with sizing context.
Future<String?> showCountryPickerSheet(
  BuildContext context, {
  required String selectedAlpha2,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => _CountryPickerBody(selectedAlpha2: selectedAlpha2),
  );
}

class _CountryPickerBody extends StatefulWidget {
  const _CountryPickerBody({required this.selectedAlpha2});

  final String selectedAlpha2;

  @override
  State<_CountryPickerBody> createState() => _CountryPickerBodyState();
}

class _CountryPickerBodyState extends State<_CountryPickerBody> {
  late List<CountrySizingEntry> _filtered;
  final _search = TextEditingController();

  List<CountrySizingEntry> get _catalog => kCountrySizingEntries
      .where(
        (e) =>
            e.alpha2.toUpperCase() == widget.selectedAlpha2.toUpperCase() ||
            !ExcludedRegions.isExcludedCountryAlpha2(e.alpha2),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    _filtered = List<CountrySizingEntry>.from(_catalog);
    _search.addListener(_applyFilter);
  }

  void _applyFilter() {
    final q = _search.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = List<CountrySizingEntry>.from(_catalog);
      } else {
        _filtered = _catalog.where((e) {
          final code = e.alpha2.toLowerCase().contains(q);
          final name = e.name.toLowerCase().contains(q);
          return code || name;
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _search.removeListener(_applyFilter);
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final cs = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.92,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.countrySheetTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: TextField(
                controller: _search,
                autofocus: true,
                style: TextStyle(color: cs.onSurface),
                decoration: InputDecoration(
                  hintText: l10n.countrySheetSearchHint,
                  hintStyle: TextStyle(color: cs.onSurfaceVariant.withValues(alpha: 0.8)),
                  prefixIcon: Icon(Icons.search, color: cs.primary),
                  filled: true,
                  fillColor: cs.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: cs.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: cs.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: cs.primary, width: 1.4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                l10n.countryCountriesCount('${_filtered.length}'),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.fromLTRB(8, 0, 8, 16 + bottomInset),
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  final e = _filtered[index];
                  final selected = e.alpha2 == widget.selectedAlpha2.toUpperCase();
                  return ListTile(
                    dense: true,
                    selected: selected,
                    selectedTileColor: cs.primary.withValues(alpha: 0.12),
                    title: Text(
                      e.name,
                      style: TextStyle(
                        color: selected ? cs.primary : cs.onSurface,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      '${e.alpha2} · ${_columnLabel(l10n, e.primaryColumn)}',
                      
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    onTap: () => Navigator.pop(context, e.alpha2),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

String _columnLabel(AppLocalizations l10n, SizeInputColumn col) =>
    sizeColumnLabel(l10n, col);
