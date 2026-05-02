import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../core/subscription/revenue_cat_sdk_state.dart';
import '../../core/subscription/tripmetic_pro_entitlement.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/l10n_helpers.dart';
import '../../features/settings/presentation/settings_screen.dart';
import 'fullscreen_tool_scaffold.dart';
import 'tripmetic_app_bar_title.dart';

const Duration _kPurchasesNetworkTimeout = Duration(seconds: 8);

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  bool _ranColdStartPaywallGate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _coldStartPaywallGate());
  }

  /// After the first Flutter frame, send non‑subscribers to [/paywall]. This must not
  /// run inside GoRouter.redirect (that blocks the native launch screen until complete).
  Future<void> _coldStartPaywallGate() async {
    if (_ranColdStartPaywallGate || !mounted) return;
    _ranColdStartPaywallGate = true;
    if (!revenueCatSdkConfigured) return;
    try {
      final info = await Purchases.getCustomerInfo().timeout(_kPurchasesNetworkTimeout);
      if (!mounted) return;
      if (!TripmeticProEntitlement.isUnlocked(info)) {
        context.go('/paywall');
      }
    } catch (e, st) {
      debugPrint('Cold-start subscription gate skipped: $e\n$st');
    }
  }

  Future<void> _navigateIfPro(
    BuildContext context,
    Widget destinationScreen,
  ) async {
    if (!revenueCatSdkConfigured) {
      if (!context.mounted) return;
      Navigator.of(
        context,
        rootNavigator: true,
      ).push(MaterialPageRoute<void>(builder: (context) => destinationScreen));
      return;
    }
    try {
      final customerInfo =
          await Purchases.getCustomerInfo().timeout(_kPurchasesNetworkTimeout);

      if (!context.mounted) return;

      if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).push(MaterialPageRoute<void>(builder: (context) => destinationScreen));
        return;
      }
    } catch (e, st) {
      debugPrint('Settings gate error: $e\n$st');
    }
    if (context.mounted) context.go('/paywall');
  }

  Future<void> _onTabTapped(int index) async {
    if (!revenueCatSdkConfigured) {
      widget.navigationShell.goBranch(index);
      return;
    }
    try {
      final customerInfo =
          await Purchases.getCustomerInfo().timeout(_kPurchasesNetworkTimeout);
      if (!mounted) return;

      if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
        widget.navigationShell.goBranch(index);
        return;
      }
    } catch (e, st) {
      debugPrint('Tab switch error: $e\n$st');
    }
    if (!mounted) return;
    context.go('/paywall');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final branchTitles = [
      l10n.navCurrency,
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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: widget.navigationShell,
      ),
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
