import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/l10n_helpers.dart';

import '../../data/crypto_asset.dart';
import '../../data/crypto_catalog.dart';

final _mockUsdLarge = NumberFormat('#,##0.00', 'en_US');

String _formatMockUsd(CryptoAsset a) {
  final v = a.usdPerUnit;
  if (v >= 1) return _mockUsdLarge.format(v);
  if (v >= 0.0001) return v.toStringAsFixed(6);
  return v.toStringAsExponential(2);
}

/// Searchable list of all symbols in [kCryptoCatalog].
Future<String?> showCryptoPickerSheet(
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
    builder: (ctx) => _CryptoPickerBody(
      selectedCode: selectedCode,
      excludedCodes: excludedCodes,
    ),
  );
}

class _CryptoPickerBody extends StatefulWidget {
  const _CryptoPickerBody({
    required this.selectedCode,
    required this.excludedCodes,
  });

  final String selectedCode;
  final Set<String> excludedCodes;

  @override
  State<_CryptoPickerBody> createState() => _CryptoPickerBodyState();
}

class _CryptoPickerBodyState extends State<_CryptoPickerBody> {
  late final List<CryptoAsset> _all;
  late List<CryptoAsset> _filtered;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    final upperSel = widget.selectedCode.toUpperCase();
    final ex = widget.excludedCodes.map((e) => e.toUpperCase()).toSet();
    _all = kCryptoCatalog
        .where(
          (a) => a.id == upperSel || !ex.contains(a.id),
        )
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    _filtered = _all;
    _search.addListener(_applyFilter);
  }

  void _applyFilter() {
    final q = _search.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = _all;
      } else {
        _filtered = _all.where((a) {
          final hitCode = a.id.toLowerCase().contains(q);
          final hitName = a.name.toLowerCase().contains(q);
          return hitCode || hitName;
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
                      l10n.cryptoSheetTitle,
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
                  hintText: l10n.currencyPickerSearchHint,
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
                  final a = _filtered[index];
                  final selected = a.id == widget.selectedCode.toUpperCase();
                  return ListTile(
                    dense: true,
                    selected: selected,
                    selectedTileColor: cs.primary.withValues(alpha: 0.12),
                    title: Text(
                      '${a.id} — ${a.name}',
                      style: TextStyle(
                        color: selected ? cs.primary : cs.onSurface,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      l10n.cryptoMockPerUnit('\$${_formatMockUsd(a)}'),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    onTap: () => Navigator.pop(context, a.id),
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
