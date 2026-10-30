import 'package:flutter/material.dart';
import 'package:sealed_countries/sealed_countries.dart';
import '../../../core/geo/excluded_regions.dart';
import '../../../l10n/l10n_helpers.dart';

/// One selectable row: a country and one of its official currencies.
class BudgetCountryCurrencyRow {
  BudgetCountryCurrencyRow({
    required this.countryName,
    required this.currencyCode,
  });

  final String countryName;
  final String currencyCode;

  String get label => '$countryName — $currencyCode';

  String get sortKey => '${countryName.toLowerCase()} $currencyCode';
}

/// Built once from [WorldCountry.list] (country + each currency).
final List<BudgetCountryCurrencyRow> kBudgetCountryCurrencyRows = () {
  final out = <BudgetCountryCurrencyRow>[];
  for (final country in WorldCountry.list) {
    final common = country.name.common;
    if (ExcludedRegions.isExcludedCountryName(common) ||
        ExcludedRegions.isExcludedCountryAlpha2(country.codeShort)) {
      continue;
    }
    final curs = country.currencies;
    if (curs == null || curs.isEmpty) continue;
    for (final fiat in curs) {
      if (ExcludedRegions.isExcludedCurrencyCode(fiat.code)) continue;
      out.add(BudgetCountryCurrencyRow(
        countryName: common,
        currencyCode: fiat.code,
      ));
    }
  }
  out.sort((a, b) => a.sortKey.compareTo(b.sortKey));
  return out;
}();

/// Search countries; each option shows country name and ISO currency code.
Future<String?> showBudgetDestinationCountryPicker(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (ctx) {
      return _BudgetCountryPickerDialog(rows: kBudgetCountryCurrencyRows);
    },
  );
}

class _BudgetCountryPickerDialog extends StatefulWidget {
  const _BudgetCountryPickerDialog({required this.rows});

  final List<BudgetCountryCurrencyRow> rows;

  @override
  State<_BudgetCountryPickerDialog> createState() => _BudgetCountryPickerDialogState();
}

class _BudgetCountryPickerDialogState extends State<_BudgetCountryPickerDialog> {
  late final TextEditingController _query;
  late List<BudgetCountryCurrencyRow> _filtered;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController();
    _filtered = List<BudgetCountryCurrencyRow>.from(widget.rows);
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  void _applyFilter(String q) {
    final s = q.trim().toLowerCase();
    if (s.isEmpty) {
      setState(() => _filtered = List<BudgetCountryCurrencyRow>.from(widget.rows));
      return;
    }
    setState(() {
      _filtered = widget.rows.where((r) {
        return r.countryName.toLowerCase().contains(s) ||
            r.currencyCode.toLowerCase().contains(s) ||
            r.label.toLowerCase().contains(s);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.budgetDestinationTitle),
      content: SizedBox(
        width: double.maxFinite,
        height: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _query,
              autofocus: true,
              decoration: InputDecoration(
                hintText: l10n.budgetDestinationSearchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                isDense: true,
              ),
              onChanged: _applyFilter,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: _filtered.length,
                  itemBuilder: (context, i) {
                    final row = _filtered[i];
                    return ListTile(
                      dense: true,
                      title: Text(
                        row.countryName,
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        row.currencyCode,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          letterSpacing: 0.4,
                        ),
                      ),
                      onTap: () => Navigator.pop(context, row.currencyCode),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
      ],
    );
  }
}
