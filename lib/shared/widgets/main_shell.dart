import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../core/subscription/tripmetic_pro_entitlement.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/l10n_helpers.dart';
import '../../features/settings/presentation/settings_screen.dart';
import 'fullscreen_tool_scaffold.dart';
import 'tripmetic_app_bar_title.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  Future<void> _navigateIfPro(
    BuildContext context,
    Widget destinationScreen,
  ) async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();

      if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
        if (context.mounted) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).push(MaterialPageRoute(builder: (context) => destinationScreen));
        }
      } else {
        await RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
        customerInfo = await Purchases.getCustomerInfo();
        if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
          if (context.mounted) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).push(MaterialPageRoute(builder: (context) => destinationScreen));
          }
        }
      }
    } catch (e) {
      debugPrint('Paywall error: $e');
      await RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
    }
  }

  Future<void> _onTabTapped(int index) async {
    try {
      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      if (!mounted) return;

      if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
        // User is paid. Switch the tab.
        widget.navigationShell.goBranch(index);
      } else {
        // User is free. Do NOT switch the tab. Show the paywall.
        await RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
      }
    } catch (e) {
      debugPrint('Tab switch error: $e');
      await RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final branchTitles = [
      l10n.navCurrency,
      l10n.navItinerary,
      l10n.navOfflineMap,
      l10n.navMoreTools,
    ];
    final i = widget.navigationShell.currentIndex.clamp(
      0,
      branchTitles.length - 1,
    );
    return Scaffold(
      appBar: AppBar(
        title: TripmeticAppBarTitle(subtitle: branchTitles[i]),
        actions: [
          IconButton(
            tooltip: l10n.settingsAndInfo,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _navigateIfPro(
              context,
              FullscreenToolScaffold(
                subtitle: l10n.settingsAndInfo,
                child: const SettingsScreen(),
              ),
            ),
          ),
        ],
      ),
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _onTabTapped,
        destinations: [
          NavigationDestination(
            icon: const Icon(
              Icons.currency_exchange_outlined,
              color: AppColors.navIconUnselected,
            ),
            selectedIcon: const Icon(
              Icons.currency_exchange_rounded,
              color: AppColors.accent,
            ),
            label: l10n.navCurrency,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.route_outlined,
              color: AppColors.navIconUnselected,
            ),
            selectedIcon: const Icon(Icons.route, color: AppColors.accent),
            label: l10n.navItinerary,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined, color: AppColors.navIconUnselected),
            selectedIcon: const Icon(Icons.map, color: AppColors.accent),
            label: l10n.navOfflineMap,
          ),
          NavigationDestination(
            icon: const Icon(Icons.apps_outlined, color: AppColors.navIconUnselected),
            selectedIcon: const Icon(Icons.apps, color: AppColors.accent),
            label: l10n.navMoreTools,
          ),
        ],
      ),
    );
  }
}
