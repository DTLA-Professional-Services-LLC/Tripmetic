import 'package:flutter/material.dart';
import 'package:sealed_currencies/sealed_currencies.dart';
import '../../../../l10n/l10n_helpers.dart';

/// Searchable list of all ISO 4217 currencies from [FiatCurrency.listExtended].
Future<String?> showCurrencyPickerSheet(
  BuildContext context, {
  required String selectedCode,
  required Set<String> excludedCodes,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => _CurrencyPickerBody(
      selectedCode: selectedCode,
      excludedCodes: excludedCodes,
    ),
  );
}

class _CurrencyPickerBody extends StatefulWidget {
  const _CurrencyPickerBody({
    required this.selectedCode,
    required this.excludedCodes,
  });

  final String selectedCode;
  final Set<String> excludedCodes;

  @override
  State<_CurrencyPickerBody> createState() => _CurrencyPickerBodyState();
}

class _CurrencyPickerBodyState extends State<_CurrencyPickerBody> {
  late final List<FiatCurrency> _all;
  late List<FiatCurrency> _filtered;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    final upperSel = widget.selectedCode.toUpperCase();
    _all = FiatCurrency.listExtended
        .where(
          (c) =>
              c.code == upperSel ||
              !widget.excludedCodes.contains(c.code),
        )
        .toList()
      ..sort((a, b) => a.code.compareTo(b.code));
    _filtered = _all;
    _search.addListener(_applyFilter);
  }

  void _applyFilter() {
    final q = _search.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = _all;
      } else {
        _filtered = _all.where((c) {
          final hitCode = c.code.toLowerCase().contains(q);
          final hitName = c.name.toLowerCase().contains(q);
          final hitNum = c.codeNumeric.contains(q);
          return hitCode || hitName || hitNum;
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
                      l10n.currencySheetTitle,
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
                  hintText: l10n.currencySheetSearchHint,
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
                l10n.currencySheetCountShown('${_filtered.length}', '${_all.length}'),
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
                  final c = _filtered[index];
                  final selected = c.code == widget.selectedCode.toUpperCase();
                  final sym = c.symbol ?? c.code;
                  return ListTile(
                    dense: true,
                    selected: selected,
                    selectedTileColor: cs.primary.withValues(alpha: 0.12),
                    title: Text(
                      '${c.code} — ${c.name}',
                      style: TextStyle(
                        color: selected ? cs.primary : cs.onSurface,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      '$sym · ISO ${c.codeNumeric}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    onTap: () => Navigator.pop(context, c.code),
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
