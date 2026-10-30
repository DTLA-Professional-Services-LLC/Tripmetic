import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../application/packing_providers.dart';
import '../domain/packing_category.dart';
import '../domain/packing_item.dart';
import '../domain/packing_icon_registry.dart';
import 'widgets/add_packing_item_sheet.dart';

/// Dynamic packing & logistics checklist with Hive persistence.
class PackingScreen extends ConsumerWidget {
  const PackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(packingListProvider);
    final hideDone = ref.watch(hideCompletedPackingProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    final visible = hideDone
        ? items.where((e) => !e.isCompleted).toList()
        : List<PackingItem>.from(items);

    final byCategory = <String, List<PackingItem>>{};
    for (final c in PackingCategory.all) {
      byCategory[c] = visible.where((e) => e.category == c).toList();
    }

    final isPro = ref.watch(isTripmeticProProvider);

    return ProGlassOverlay(
      featureId: NavFeatureIds.packing,
      isPro: isPro,
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                  child: Text(
                    l10n.packingHeader,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  title: Text(
                    l10n.packingHideCompleted,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    l10n.packingHideCompletedSubtitle,
                    style: theme.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  value: hideDone,
                  onChanged: (v) {
                    ref.read(hideCompletedPackingProvider.notifier).state = v;
                  },
                ),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              hideDone ? l10n.packingEmptyHidden : l10n.packingEmpty,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                            ),
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
                          children: [
                            for (final cat in PackingCategory.all)
                              if ((byCategory[cat] ?? []).isNotEmpty)
                                _CategorySection(
                                  category: cat,
                                  items: byCategory[cat]!,
                                  categoryHeader: packingCategoryHeader(l10n, cat),
                                ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () => showAddPackingItemSheet(context, ref),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.category,
    required this.items,
    required this.categoryHeader,
  });

  final String category;
  final List<PackingItem> items;
  final String categoryHeader;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        color: cs.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: cs.primary.withValues(alpha: 0.28)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                categoryHeader,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              for (final item in items) _PackingItemRow(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

class _PackingItemRow extends ConsumerWidget {
  const _PackingItemRow({required this.item});

  final PackingItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final title =
        packingLocalizedStarterTitle(context.l10n, item.id) ?? item.title;
    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      decoration: item.isCompleted ? TextDecoration.lineThrough : null,
      color: item.isCompleted ? cs.onSurfaceVariant : null,
    );

    return Dismissible(
      key: ValueKey('pack-${item.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        ref.read(packingListProvider.notifier).deleteItem(item.id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: cs.error.withValues(alpha: 0.25),
        child: Icon(Icons.delete_outline, color: cs.error),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              packingIconForName(item.iconName),
              color: cs.primary,
              size: 26,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: titleStyle,
              ),
            ),
            if (item.quantity > 1) ...[
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: const Icon(Icons.remove_circle_outline, size: 22),
                onPressed: item.isCompleted
                    ? null
                    : () {
                        final n = item.quantity - 1;
                        ref.read(packingListProvider.notifier).setQuantity(item.id, n);
                      },
              ),
              Text(
                '${item.quantity}',
                style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: const Icon(Icons.add_circle_outline, size: 22),
                onPressed: item.isCompleted
                    ? null
                    : () {
                        ref.read(packingListProvider.notifier).setQuantity(item.id, item.quantity + 1);
                      },
              ),
              const SizedBox(width: 4),
            ],
            Checkbox(
              value: item.isCompleted,
              onChanged: (_) {
                ref.read(packingListProvider.notifier).toggleCompleted(item.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
