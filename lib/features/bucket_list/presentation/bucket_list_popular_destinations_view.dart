import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../application/bucket_list_provider.dart';
import '../domain/bucket_list_category_colors.dart';
import '../domain/popular_destinations_data.dart';
import '../domain/travel_destination.dart';

/// Popular cities by region — toggles sync with [bucketListProvider] (list + map).
class BucketListPopularDestinationsView extends ConsumerWidget {
  const BucketListPopularDestinationsView({
    super.key,
    required this.destinations,
    required this.allowEditing,
  });

  final List<TravelDestination> destinations;
  final bool allowEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final liveDestinations = ref.watch(bucketListProvider).maybeWhen(
          data: (list) => list,
          orElse: () => destinations,
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      children: [
        Text(
          l10n.bucketListPopularHint,
          style: theme.textTheme.bodySmall?.copyWith(
            color: cs.onSurface,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 8),
        ...kPopularDestinationRegions.map(
          (region) => _RegionExpansion(
            region: region,
            destinations: liveDestinations,
            allowEditing: allowEditing,
          ),
        ),
      ],
    );
  }
}

class _RegionExpansion extends ConsumerWidget {
  const _RegionExpansion({
    required this.region,
    required this.destinations,
    required this.allowEditing,
  });

  final PopularDestinationRegion region;
  final List<TravelDestination> destinations;
  final bool allowEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final accentIcon = AppColors.accentOnSurface(theme.brightness);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: cs.surfaceContainerHighest,
      elevation: theme.cardTheme.elevation ?? 0,
      shadowColor: theme.shadowColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cs.outline.withValues(alpha: 0.45)),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: false,
        collapsedTextColor: cs.onSurface,
        textColor: cs.onSurface,
        collapsedIconColor: cs.onSurfaceVariant,
        iconColor: accentIcon,
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        title: Text(
          region.name,
          style: theme.textTheme.titleSmall?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          '${region.cities.length} cities',
          style: theme.textTheme.labelSmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
        children: region.cities
            .map(
              (city) => _PopularCityRow(
                city: city,
                destinations: destinations,
                allowEditing: allowEditing,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PopularCityRow extends ConsumerWidget {
  const _PopularCityRow({
    required this.city,
    required this.destinations,
    required this.allowEditing,
  });

  final PopularDestinationCity city;
  final List<TravelDestination> destinations;
  final bool allowEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notifier = ref.read(bucketListProvider.notifier);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final list = ref.watch(bucketListProvider).maybeWhen(
          data: (d) => d,
          orElse: () => destinations,
        );

    final been = notifier.findDestination(
      list: list,
      city: city.city,
      country: city.country,
      category: TravelDestinationCategory.been,
    );
    final live = notifier.findDestination(
      list: list,
      city: city.city,
      country: city.country,
      category: TravelDestinationCategory.live,
    );
    final lived = notifier.findDestination(
      list: list,
      city: city.city,
      country: city.country,
      category: TravelDestinationCategory.lived,
    );
    final want = notifier.findDestination(
      list: list,
      city: city.city,
      country: city.country,
      category: TravelDestinationCategory.want,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city.city,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  city.country,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _CategoryToggle(
                    label: l10n.bucketListCategoryBeen,
                    icon: Icons.check_circle_outline_rounded,
                    activeIcon: Icons.check_circle_rounded,
                    category: TravelDestinationCategory.been,
                    isActive: been != null,
                    enabled: allowEditing,
                    onPressed: () => unawaited(
                      notifier.toggleDestinationCategory(
                        city: city.city,
                        country: city.country,
                        latitude: city.latitude,
                        longitude: city.longitude,
                        category: TravelDestinationCategory.been,
                      ),
                    ),
                  ),
                  _CategoryToggle(
                    label: l10n.bucketListCategoryLive,
                    icon: Icons.apartment_outlined,
                    activeIcon: Icons.apartment,
                    category: TravelDestinationCategory.live,
                    isActive: live != null,
                    enabled: allowEditing,
                    onPressed: () => unawaited(
                      notifier.toggleDestinationCategory(
                        city: city.city,
                        country: city.country,
                        latitude: city.latitude,
                        longitude: city.longitude,
                        category: TravelDestinationCategory.live,
                      ),
                    ),
                  ),
                  _CategoryToggle(
                    label: l10n.bucketListCategoryLived,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    category: TravelDestinationCategory.lived,
                    isActive: lived != null,
                    enabled: allowEditing,
                    onPressed: () => unawaited(
                      notifier.toggleDestinationCategory(
                        city: city.city,
                        country: city.country,
                        latitude: city.latitude,
                        longitude: city.longitude,
                        category: TravelDestinationCategory.lived,
                      ),
                    ),
                  ),
                  _CategoryToggle(
                    label: l10n.bucketListCategoryWant,
                    icon: Icons.favorite_border_rounded,
                    activeIcon: Icons.favorite_rounded,
                    category: TravelDestinationCategory.want,
                    isActive: want != null,
                    enabled: allowEditing,
                    onPressed: () => unawaited(
                      notifier.toggleDestinationCategory(
                        city: city.city,
                        country: city.country,
                        latitude: city.latitude,
                        longitude: city.longitude,
                        category: TravelDestinationCategory.want,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryToggle extends StatelessWidget {
  const _CategoryToggle({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.category,
    required this.isActive,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final TravelDestinationCategory category;
  final bool isActive;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final accent = BucketListCategoryColors.readableOnSurface(
      category,
      theme.brightness,
    );
    final fg = isActive ? accent : cs.onSurfaceVariant;
    final bg = isActive ? accent.withValues(alpha: 0.16) : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: SizedBox(
        width: 48,
        child: Material(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isActive ? activeIcon : icon,
                    size: 22,
                    color: enabled ? fg : fg.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      height: 1.1,
                      color: enabled ? fg : fg.withValues(alpha: 0.4),
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
