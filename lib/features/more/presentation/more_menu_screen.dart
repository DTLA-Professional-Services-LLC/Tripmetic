import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/navigation/navigation_preferences_provider.dart';
import '../../../core/subscription/revenue_cat_ui_actions.dart';
import '../../../core/subscription/subscription_nav.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';

/// Fifth tab: all tools, customization, and Pro upsell.
class MoreMenuScreen extends ConsumerStatefulWidget {
  const MoreMenuScreen({super.key});

  @override
  ConsumerState<MoreMenuScreen> createState() => _MoreMenuScreenState();
}

List<String> _moreMenuFreeIdsInOrder() {
  const order = [
    NavFeatureIds.dashboard,
    NavFeatureIds.dualClock,
    NavFeatureIds.units,
    NavFeatureIds.settings,
  ];
  final allowed = NavFeatureIds.moreMenuIds.toSet();
  return [
    for (final id in order)
      if (allowed.contains(id) && NavFeatureRoutes.isFree(id)) id,
  ];
}

List<String> _moreMenuProIdsInOrder() {
  const order = [
    NavFeatureIds.itinerary,
    NavFeatureIds.currency,
    NavFeatureIds.offlineMap,
    NavFeatureIds.bucketList,
    NavFeatureIds.groupPlanner,
    NavFeatureIds.budget,
    NavFeatureIds.vault,
    NavFeatureIds.scheduler,
    NavFeatureIds.packing,
    NavFeatureIds.crypto,
    NavFeatureIds.tipCalculator,
    NavFeatureIds.sizeConverter,
    NavFeatureIds.mindMap,
  ];
  final allowed = NavFeatureIds.moreMenuIds.toSet();
  final out = <String>[];
  for (final id in order) {
    if (allowed.contains(id) && NavFeatureRoutes.isPro(id)) {
      out.add(id);
    }
  }
  for (final id in NavFeatureIds.moreMenuIds) {
    if (NavFeatureRoutes.isPro(id) && !out.contains(id)) {
      out.add(id);
    }
  }
  return out;
}

class _MoreMenuScreenState extends ConsumerState<MoreMenuScreen> {
  bool _editMode = false;
  /// Four bottom-bar slots; `null` = empty (only while editing).
  List<String?> _slotDraft = List<String?>.filled(4, null);

  bool get _canSave =>
      _slotDraft.length == 4 &&
      _slotDraft.every((e) => e != null) &&
      _slotDraft.map((e) => e!).toSet().length == 4;

  void _initSlotsFromPins(List<String> pins) {
    _slotDraft = List<String?>.filled(4, null);
    if (pins.length >= 4) {
      for (var i = 0; i < 4; i++) {
        _slotDraft[i] = pins[i];
      }
      return;
    }
    for (var i = 0; i < NavFeatureIds.defaultPinned.length && i < 4; i++) {
      _slotDraft[i] = NavFeatureIds.defaultPinned[i];
    }
  }

  bool _slotContains(String id) => _slotDraft.any((s) => s == id);

  Iterable<String> _availableIds() sync* {
    for (final id in NavFeatureIds.pinnableIds) {
      if (!_slotContains(id)) yield id;
    }
  }

  void _removeSlot(int index) {
    setState(() => _slotDraft[index] = null);
  }

  void _addPin(String id) {
    final idx = _slotDraft.indexWhere((e) => e == null);
    if (idx < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.navPinFullHint)),
      );
      return;
    }
    setState(() => _slotDraft[idx] = id);
  }

  Future<void> _savePins() async {
    if (!_canSave) return;
    final ids = _slotDraft.map((e) => e!).toList();
    await ref.read(navigationPreferencesProvider.notifier).setPinned(ids);
    if (!mounted) return;
    setState(() => _editMode = false);
  }

  void _cancelEdit(List<String> pins) {
    setState(() {
      _editMode = false;
      _initSlotsFromPins(pins);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pinsAsync = ref.watch(navigationPreferencesProvider);
    final isPro = ref.watch(isTripmeticProProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return pinsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('$e')),
      data: (pins) {
        final freeMenuIds = _moreMenuFreeIdsInOrder();
        final proMenuIds = _moreMenuProIdsInOrder();
        return SafeArea(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _TripmeticProSubscriptionCard(),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.moreToolsHeader,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          if (!_editMode)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _editMode = true;
                                  _initSlotsFromPins(
                                    pins.length == 4 ? pins : NavFeatureIds.defaultPinned,
                                  );
                                });
                              },
                              child: Text(l10n.navEditNavigation),
                            )
                          else
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () => _cancelEdit(
                                    pins.length == 4 ? pins : NavFeatureIds.defaultPinned,
                                  ),
                                  child: Text(l10n.commonCancel),
                                ),
                                FilledButton(
                                  onPressed: _canSave ? _savePins : null,
                                  child: Text(l10n.navSavePins),
                                ),
                              ],
                            ),
                        ],
                      ),
                      Text(
                        _editMode ? l10n.navEditPinnedHint : l10n.moreToolsSubtitle,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      if (_editMode) ...[
                        const SizedBox(height: 16),
                        Text(
                          l10n.navPinnedSectionTitle,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ReorderableListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          buildDefaultDragHandles: false,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              var ni = newIndex;
                              if (ni > oldIndex) ni--;
                              final a = _slotDraft[oldIndex];
                              _slotDraft[oldIndex] = _slotDraft[ni];
                              _slotDraft[ni] = a;
                            });
                          },
                          children: [
                            for (var i = 0; i < 4; i++)
                              _PinnedSlotTile(
                                key: ValueKey('slot_${i}_${_slotDraft[i]}'),
                                index: i,
                                slotId: _slotDraft[i],
                                onRemove: () => _removeSlot(i),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          l10n.navAvailableSectionTitle,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._availableIds().map(
                          (id) => Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: _availableCardBorderColor(context, id)),
                            ),
                            child: ListTile(
                              leading: Icon(
                                navFeatureIcon(id),
                                color: NavFeatureRoutes.isFree(id)
                                    ? AppColors.freeTierOnSurface(theme.brightness)
                                    : cs.primary,
                              ),
                              title: Text(navFeatureTitle(l10n, id)),
                              subtitle: navFeatureSubtitle(l10n, id).isEmpty
                                  ? null
                                  : Text(navFeatureSubtitle(l10n, id)),
                              trailing: IconButton(
                                tooltip: l10n.navAddToPinned,
                                icon: const Icon(Icons.add_circle_outline_rounded),
                                color: cs.primary,
                                onPressed: () => _addPin(id),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),
              if (!_editMode) ...[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      l10n.moreMenuSectionFree,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.05,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final id = freeMenuIds[index];
                        return _FeatureTile(
                          key: ValueKey('free_$id'),
                          title: navFeatureTitle(l10n, id),
                          subtitle: navFeatureSubtitle(l10n, id),
                          icon: navFeatureIcon(id),
                          showFreeBadge: true,
                          showProBadge: false,
                          onTap: () => openNavFeature(context, ref, id),
                        );
                      },
                      childCount: freeMenuIds.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 14, 12, 6),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      l10n.moreMenuSectionPro,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.05,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final id = proMenuIds[index];
                        return _FeatureTile(
                          key: ValueKey('pro_$id'),
                          title: navFeatureTitle(l10n, id),
                          subtitle: navFeatureSubtitle(l10n, id),
                          icon: navFeatureIcon(id),
                          showFreeBadge: false,
                          showProBadge: !isPro,
                          onTap: () => openNavFeature(context, ref, id),
                        );
                      },
                      childCount: proMenuIds.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 28),
                  sliver: SliverToBoxAdapter(
                    child: Material(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => context.push('/our-apps'),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.accent.withValues(alpha: 0.45),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.apps_rounded,
                                color: AppColors.accentOnSurface(theme.brightness),
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.ourAppsMenuTitle,
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      l10n.ourAppsMenuSubtitle,
                                      style: theme.textTheme.labelMedium?.copyWith(
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: cs.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

Color _slotBorderColor(BuildContext context, String? slotId) {
  final cs = Theme.of(context).colorScheme;
  if (slotId == null) return cs.outline.withValues(alpha: 0.5);
  if (NavFeatureRoutes.isFree(slotId)) {
    return AppColors.freeTierOnSurface(Theme.of(context).brightness)
        .withValues(alpha: 0.55);
  }
  return cs.primary.withValues(alpha: 0.45);
}

Color _availableCardBorderColor(BuildContext context, String id) {
  final cs = Theme.of(context).colorScheme;
  if (NavFeatureRoutes.isFree(id)) {
    return AppColors.freeTierOnSurface(Theme.of(context).brightness)
        .withValues(alpha: 0.45);
  }
  return cs.primary.withValues(alpha: 0.35);
}

class _PinnedSlotTile extends StatelessWidget {
  const _PinnedSlotTile({
    super.key,
    required this.index,
    required this.slotId,
    required this.onRemove,
  });

  final int index;
  final String? slotId;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _slotBorderColor(context, slotId)),
      ),
      child: ListTile(
        leading: ReorderableDragStartListener(
          index: index,
          child: Icon(Icons.drag_handle_rounded, color: cs.onSurfaceVariant),
        ),
        title: slotId == null
            ? Text(
                l10n.navEmptySlot,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              )
            : Text(navFeatureTitle(l10n, slotId!)),
        subtitle: slotId == null
            ? null
            : Text(
                navFeatureSubtitle(l10n, slotId!),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        trailing: IconButton(
          tooltip: l10n.navRemoveFromPinned,
          icon: const Icon(Icons.remove_circle_outline_rounded),
          color: slotId == null ? cs.outline : cs.error,
          onPressed: slotId == null ? null : onRemove,
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.showFreeBadge,
    required this.showProBadge,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool showFreeBadge;
  final bool showProBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final freeColor = AppColors.freeTierOnSurface(theme.brightness);
    final borderColor = showFreeBadge
        ? freeColor.withValues(alpha: 0.55)
        : cs.primary.withValues(alpha: 0.45);
    final iconColor = showFreeBadge ? freeColor : cs.primary;

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 26),
                  const Spacer(),
                  if (showFreeBadge)
                    Text(
                      l10n.navFeatureBadgeFree,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: freeColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    )
                  else if (showProBadge)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        l10n.navFeatureBadgePro,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF3E2723),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripmeticProSubscriptionCard extends ConsumerWidget {
  const _TripmeticProSubscriptionCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isPro = ref.watch(isTripmeticProProvider);
    final l10n = context.l10n;

    Future<void> openPaywall() async {
      final messenger = ScaffoldMessenger.of(context);
      final result = await presentTripmeticPaywallIfNeeded();
      if (!context.mounted) return;
      if (result == PaywallResult.purchased || result == PaywallResult.restored) {
        await ref.read(customerInfoProvider.notifier).sync();
        messenger.showSnackBar(SnackBar(content: Text(l10n.proWelcome)));
      } else if (result == PaywallResult.error) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.proPaywallError)));
      }
    }

    Future<void> openCustomerCenter() async {
      await presentTripmeticCustomerCenter(
        onRestoreFailed: (err) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.proRestoreFailed(err.message))),
          );
        },
      );
      if (!context.mounted) return;
      await ref.read(customerInfoProvider.notifier).sync();
    }

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.workspace_premium_outlined, color: AppColors.accent, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.proName,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                if (isPro)
                  Chip(
                    label: Text(l10n.proActive),
                    backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                    labelStyle: TextStyle(color: AppColors.accent, fontSize: 12),
                    side: BorderSide.none,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isPro ? l10n.proManageHintPro : l10n.proManageHintFree,
              style: theme.textTheme.labelMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!isPro)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: openPaywall,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        alignment: Alignment.center,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock_open_rounded, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.upgradeNow,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              maxLines: 3,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppColors.onAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                OutlinedButton.icon(
                  onPressed: openCustomerCenter,
                  icon: const Icon(Icons.manage_accounts_outlined, size: 18),
                  label: Text(l10n.proManageSubscription),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
