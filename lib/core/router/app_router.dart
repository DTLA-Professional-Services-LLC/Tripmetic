import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/l10n_helpers.dart';
import '../../features/paywall/presentation/paywall_screen.dart';
import '../../features/crypto/presentation/crypto_tab.dart';
import '../../features/currency/presentation/currency_tab.dart';
import '../../features/map/presentation/map_screen.dart';
import '../../features/more/presentation/more_tools_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/scheduler/presentation/scheduler_tab.dart';
import '../../features/sizes/presentation/size_converter_screen.dart';
import '../../features/mindmap/presentation/mind_map_screen.dart';
import '../../features/tip/presentation/tip_calculator_screen.dart';
import '../../features/packing/presentation/packing_screen.dart';
import '../../features/trip/presentation/budget_screen.dart';
import '../../features/trip/presentation/itinerary_screen.dart';
import '../../features/vault/presentation/vault_screen.dart';
import '../../features/units/presentation/units_tab.dart';
import '../../shared/widgets/fullscreen_tool_scaffold.dart';
import '../../shared/widgets/main_shell.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(Ref _);
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);
  final router = createAppRouter(ref, notifier);
  ref.onDispose(router.dispose);
  return router;
});

GoRouter createAppRouter(Ref ref, RouterNotifier notifier) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/currency',
    refreshListenable: notifier,
    routes: [
      GoRoute(
        path: '/paywall',
        builder: (context, state) => const PaywallScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Index 0 — Currency
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/currency',
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: CurrencyTab()),
              ),
            ],
          ),
          // Index 1 — Offline Map
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/offline-map',
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: OfflineMapScreen()),
              ),
            ],
          ),
          // Index 2 — More Tools (also the upgrade hub for non-Pro users).
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: MoreToolsScreen()),
              ),
            ],
          ),
        ],
      ),
      // Demoted from bottom nav — pushed full-screen from More Tools.
      GoRoute(
        path: '/itinerary',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.navItinerary,
          child: const ItineraryScreen(),
        ),
      ),
      GoRoute(
        path: '/budget',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.toolBudget,
          child: const BudgetScreen(),
        ),
      ),
      GoRoute(
        path: '/scheduler',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.toolTimeDate,
          child: const SchedulerTab(),
        ),
      ),
      GoRoute(
        path: '/packing',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.toolPacking,
          child: const PackingScreen(),
        ),
      ),
      // Miscellaneous tool routes (unchanged).
      GoRoute(
        path: '/settings',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.toolSettingsInfo,
          child: const SettingsScreen(),
        ),
      ),
      GoRoute(
        path: '/units',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            FullscreenToolScaffold(subtitle: context.l10n.toolUnits, child: const UnitsTab()),
      ),
      GoRoute(
        path: '/crypto',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.toolCrypto,
          child: const CryptoTab(),
        ),
      ),
      GoRoute(
        path: '/tip-calculator',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const TipCalculatorScreen(),
      ),
      GoRoute(
        path: '/size-converter',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SizeConverterScreen(),
      ),
      GoRoute(
        path: '/mind-map',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.toolBrainstorm,
          child: const MindMapScreen(),
        ),
      ),
      GoRoute(
        path: '/vault',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.toolDocumentVault,
          child: const VaultScreen(),
        ),
      ),
    ],
  );
}
