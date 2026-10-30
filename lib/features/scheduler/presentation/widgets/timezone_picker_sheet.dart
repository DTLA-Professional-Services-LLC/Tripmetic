import 'package:flutter/material.dart';
import '../../../../l10n/l10n_helpers.dart';

import '../../data/timezone_catalog.dart';

/// Searchable list of every IANA timezone in the bundled database.
Future<String?> showTimezonePickerSheet(
  BuildContext context, {
  required String selectedTimezoneId,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => _TimezonePickerBody(selectedTimezoneId: selectedTimezoneId),
  );
}

class _TimezonePickerBody extends StatefulWidget {
  const _TimezonePickerBody({required this.selectedTimezoneId});

  final String selectedTimezoneId;

  @override
  State<_TimezonePickerBody> createState() => _TimezonePickerBodyState();
}

class _TimezonePickerBodyState extends State<_TimezonePickerBody> {
  late final List<String> _all;
  late List<String> _filtered;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _all = sortedTimezoneIds();
    _filtered = _all;
    _search.addListener(_applyFilter);
  }

  void _applyFilter() {
    final q = _search.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = _all;
      } else {
        _filtered = _all.where((id) => id.toLowerCase().contains(q)).toList();
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
                      l10n.timezoneSheetTitle,
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
                  hintText: l10n.timezoneSheetSearchHint,
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
                l10n.timezoneSheetCountZones('${_filtered.length}', '${_all.length}'),
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
                  final id = _filtered[index];
                  final selected = id == widget.selectedTimezoneId;
                  return ListTile(
                    dense: true,
                    selected: selected,
                    selectedTileColor: cs.primary.withValues(alpha: 0.12),
                    title: Text(
                      id,
                      style: TextStyle(
                        color: selected ? cs.primary : cs.onSurface,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                    onTap: () => Navigator.pop(context, id),
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
