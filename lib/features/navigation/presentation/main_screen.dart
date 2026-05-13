import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/main_nav_intent_provider.dart';
import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/navigation/navigation_preferences_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/more/presentation/more_menu_screen.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/tripmetic_app_bar_title.dart';
import '../../../shared/widgets/tripmetic_hub_app_bar_actions.dart';
import 'pinned_tab_body.dart';

/// Main shell: bottom bar + [IndexedStack] of pinned tools and More.
///
/// Tab index is only written via [currentTabIndexProvider] (including from
/// [goTripmeticHome]); no local tab state or post-frame tab sync.
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinsAsync = ref.watch(navigationPreferencesProvider);
    final rawIndex = ref.watch(currentTabIndexProvider);
    final tabIndex = rawIndex.clamp(0, 4);

    return pinsAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('$e'))),
      data: (pins) {
        if (pins.length < 4) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final l10n = context.l10n;
        final titles = [
          ...pins.map((id) => navFeatureTitle(l10n, id)),
          l10n.navMoreMenu,
        ];

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: TripmeticAppBarTitle(subtitle: titles[tabIndex]),
              actions: tripmeticHubAppBarActions(context, ref),
            ),
            body: IndexedStack(
              index: tabIndex,
              sizing: StackFit.expand,
              children: [
                for (var i = 0; i < 4; i++)
                  PinnedTabBody(
                    key: ValueKey<String>('pinned_${pins[i]}'),
                    featureId: pins[i],
                  ),
                const MoreMenuScreen(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: tabIndex,
              onDestinationSelected: (i) {
                ref.read(currentTabIndexProvider.notifier).state = i;
              },
              destinations: [
                ...pins.map((id) {
                  final freePin = NavFeatureRoutes.isFree(id);
                  final unselectedColor = freePin
                      ? AppColors.freeTier.withValues(alpha: 0.75)
                      : AppColors.navIconUnselected;
                  final selectedColor =
                      freePin ? AppColors.freeTier : AppColors.accent;
                  return NavigationDestination(
                    icon: Icon(navFeatureIcon(id), color: unselectedColor),
                    selectedIcon: Icon(
                      navFeatureIcon(id),
                      color: selectedColor,
                    ),
                    label: navFeatureTitle(l10n, id),
                    tooltip: navFeatureTitle(l10n, id),
                  );
                }),
                NavigationDestination(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.navIconUnselected,
                  ),
                  selectedIcon: const Icon(
                    Icons.menu_open_rounded,
                    color: AppColors.accent,
                  ),
                  label: l10n.navMoreMenu,
                  tooltip: l10n.navMoreMenu,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
