import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/l10n_helpers.dart';
import '../../application/packing_providers.dart';
import '../../domain/packing_category.dart';
import '../../domain/packing_item.dart';
import '../../domain/packing_icon_registry.dart';

Future<void> showAddPackingItemSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
      child: const _AddPackingItemBody(),
    ),
  );
}

class _AddPackingItemBody extends ConsumerStatefulWidget {
  const _AddPackingItemBody();

  @override
  ConsumerState<_AddPackingItemBody> createState() => _AddPackingItemBodyState();
}

class _AddPackingItemBodyState extends ConsumerState<_AddPackingItemBody> {
  final _titleCtrl = TextEditingController();
  String _category = PackingCategory.misc;
  int _quantity = 1;
  String _iconKey = kPackingIconChoiceKeys.first;

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      final l10n = context.l10n;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.addPackingEnterName)),
      );
      return;
    }
    final item = PackingItem(
      id: PackingItem.newId(),
      title: title,
      category: _category,
      isCompleted: false,
      quantity: _quantity.clamp(1, 999),
      iconName: _iconKey,
    );
    await ref.read(packingListProvider.notifier).addItem(item);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          Text(
            l10n.addPackingTitle,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleCtrl,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.addPackingFieldItemName,
              hintText: l10n.addPackingHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            // ignore: deprecated_member_use — value keeps selection in sync with setState (initialValue is one-shot)
            value: _category,
            decoration: InputDecoration(
              labelText: l10n.addPackingFieldCategory,
              border: const OutlineInputBorder(),
            ),
            items: [
              for (final c in PackingCategory.all)
                DropdownMenuItem(
                  value: c,
                  child: Text(packingCategoryHeader(l10n, c)),
                ),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _category = v);
            },
          ),
          const SizedBox(height: 14),
          Text(l10n.addPackingQuantity, style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton.filledTonal(
                onPressed: _quantity <= 1 ? null : () => setState(() => _quantity--),
                icon: const Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '$_quantity',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              IconButton.filledTonal(
                onPressed: _quantity >= 999 ? null : () => setState(() => _quantity++),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(l10n.addPackingIcon, style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final key in kPackingIconChoiceKeys)
                InkWell(
                  onTap: () => setState(() => _iconKey = key),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _iconKey == key
                          ? cs.primaryContainer
                          : cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _iconKey == key ? cs.primary : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Icon(packingIconForName(key), size: 26),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: _save,
            child: Text(l10n.addPackingAddToList),
          ),
        ],
      ),
    );
  }
}
