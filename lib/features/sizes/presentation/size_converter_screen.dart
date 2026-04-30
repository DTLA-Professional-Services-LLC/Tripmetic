import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/tripmetic_app_bar_title.dart';
import '../application/size_converter_notifier.dart';
import '../domain/size_conversion_data.dart';
import 'widgets/country_picker_sheet.dart';

class SizeConverterScreen extends ConsumerStatefulWidget {
  const SizeConverterScreen({super.key});

  @override
  ConsumerState<SizeConverterScreen> createState() =>
      _SizeConverterScreenState();
}

class _SizeConverterScreenState extends ConsumerState<SizeConverterScreen> {
  late final TextEditingController _sizeController;
  final _sizeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _sizeController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final s = ref.read(sizeConverterProvider);
      _sizeController.text = s.baseSizeInput;
    });
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _sizeFocus.dispose();
    super.dispose();
  }

  Future<void> _pickCountry() async {
    final s = ref.read(sizeConverterProvider);
    final picked = await showCountryPickerSheet(
      context,
      selectedAlpha2: s.countryAlpha2,
    );
    if (picked == null || !mounted) return;
    ref.read(sizeConverterProvider.notifier).setCountry(picked);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(sizeConverterProvider);
    final n = ref.read(sizeConverterProvider.notifier);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final row = s.resolvedRow;
    final entry = s.countryEntry;

    ref.listen(sizeConverterProvider, (prev, next) {
      if (prev?.category != next.category) {
        if (_sizeFocus.hasFocus) return;
        if (_sizeController.text != next.baseSizeInput) {
          _sizeController.text = next.baseSizeInput;
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: TripmeticAppBarTitle(subtitle: context.l10n.sizeConverterAppBarSubtitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        children: [
          Text(
            context.l10n.sizeConverterHeader,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.sizeConverterCategory,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Theme(
                  data: Theme.of(context).copyWith(canvasColor: cs.surface),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<SizeCategory>(
                      value: s.category,
                      isExpanded: true,
                      dropdownColor: cs.surface,
                      borderRadius: BorderRadius.circular(12),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: cs.primary,
                      ),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: cs.onSurface,
                      ),
                      items: SizeCategory.values
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(sizeCategoryDisplay(l10n, c)),
                            ),
                          )
                          .toList(),
                      onChanged: (c) {
                        if (c != null) n.setCategory(c);
                      },
                    ),
                  ),
                ),
                if (sizeCategorySizingTip(l10n, s.category) case final tip?) ...[
                  const SizedBox(height: 10),
                  Text(
                    tip,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  l10n.sizeConverterYourCountry,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _pickCountry,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: cs.primary.withValues(alpha: 0.65),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry?.name ?? s.countryAlpha2,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (entry != null)
                                  Text(
                                    l10n.sizeConverterTapToChange(entry.alpha2),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: cs.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (entry != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    entry.note,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  l10n.sizeConverterYourBaseSize,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _sizeController,
                  focusNode: _sizeFocus,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: sizeCategorySizingTip(l10n, s.category),
                    hintStyle: TextStyle(
                      color: cs.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                    filled: true,
                    fillColor: cs.surface,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'''[0-9a-zA-Z.\s¼½⅓⅔'"/x\-–]''',
                        caseSensitive: false,
                      ),
                    ),
                  ],
                  onChanged: n.setBaseSizeInput,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (row != null)
            _SizeGrid(row: row)
          else
            _NoMatch(
              message: s.baseSizeInput.trim().isEmpty
                  ? l10n.sizeNoMatchEmpty
                  : l10n.sizeNoMatchRow,
            ),
        ],
      ),
    );
  }

}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
      ),
      child: child,
    );
  }
}

class _NoMatch extends StatelessWidget {
  const _NoMatch({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline),
      ),
      child: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: cs.onSurfaceVariant),
      ),
    );
  }
}

class _SizeGrid extends StatelessWidget {
  const _SizeGrid({required this.row});

  final SizeRow row;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final cells = [
      ('US', row.us),
      ('UK', row.uk),
      ('EU', row.eu),
      ('JP', row.jp),
      ('CN', row.cn),
      ('BR', row.br),
      ('IT', row.it),
      ('AU', row.au),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.l10n.sizeEquivalentSizesHeader,
          style: theme.textTheme.labelSmall?.copyWith(
            color: cs.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, c) {
            const cols = 4;
            const spacing = 6.0;
            const runSpacing = 6.0;
            final w = (c.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(
              spacing: spacing,
              runSpacing: runSpacing,
              children: cells.map((e) {
                return SizedBox(
                  width: w,
                  child: _SizeCell(region: e.$1, value: e.$2),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SizeCell extends StatelessWidget {
  const _SizeCell({required this.region, required this.value});

  final String region;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            region,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
              fontSize: 10,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w800,
              fontSize: 15,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
