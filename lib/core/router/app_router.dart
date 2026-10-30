import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/l10n_helpers.dart';
import '../../features/account/presentation/account_management_screen.dart';
import '../../features/navigation/presentation/main_screen.dart';
import '../../features/paywall/presentation/paywall_screen.dart';
import '../../features/bucket_list/presentation/bucket_list_screen.dart';
import '../../features/crypto/presentation/crypto_tab.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/scheduler/presentation/scheduler_tab.dart';
import '../../features/sizes/presentation/size_converter_screen.dart';
import '../../features/mindmap/presentation/mind_map_screen.dart';
import '../../features/tip/presentation/tip_calculator_screen.dart';
import '../../features/packing/presentation/packing_screen.dart';
import '../../features/currency/presentation/currency_tab.dart';
import '../../features/currency/presentation/currency_widget_instruction_screen.dart';
import '../../features/map/presentation/map_screen.dart';
import '../../features/trip/presentation/budget_screen.dart';
import '../../features/group_planner/presentation/group_planner_create_trip_screen.dart';
import '../../features/group_planner/presentation/group_planner_landing_screen.dart';
import '../../features/group_planner/presentation/group_trip_route_screen.dart';
import '../../features/trip/presentation/itinerary_screen.dart';
import '../../features/vault/presentation/vault_screen.dart';
import '../../features/dual_clock/presentation/dual_city_selection_screen.dart';
import '../../features/dual_clock/presentation/widget_instruction_screen.dart';
import '../../features/more/presentation/our_apps_screen.dart';
import '../../features/units/presentation/units_tab.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/auth/presentation/sign_up_screen.dart';
import '../../shared/widgets/fullscreen_tool_scaffold.dart';
import '../../services/widget_service.dart';

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
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {
      final widgetRoute = WidgetService.routePathForExternalUri(state.uri);
      if (widgetRoute != null) {
        return widgetRoute;
      }

      final p = state.uri.path;
      if (p == '/more') {
        return '/';
      }
      if (p == '/sign-in' || p == '/sign-up') {
        if (FirebaseAuth.instance.currentUser != null) {
          return '/';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-up',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/paywall',
        builder: (context, state) => const PaywallScreen(),
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: MainScreen()),
      ),
      GoRoute(
        path: '/account',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.accountManagementTitle,
          child: const AccountManagementScreen(),
        ),
      ),
      GoRoute(
        path: '/currency',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.navCurrency,
          child: const CurrencyTab(),
        ),
      ),
      GoRoute(
        path: '/currency-widget/select',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.currencyPickerTitle,
          child: const CurrencyTab(),
        ),
      ),
      GoRoute(
        path: '/currency-widget/refresh',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.settingsCurrencyWidgetTitle,
          child: const CurrencyTab(),
        ),
      ),
      GoRoute(
        path: '/currency-widget',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.settingsCurrencyWidgetTitle,
          child: const CurrencyWidgetInstructionScreen(),
        ),
      ),
      GoRoute(
        path: '/offline-map',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.navOfflineMap,
          child: const OfflineMapScreen(),
        ),
      ),
      GoRoute(
        path: '/bucket-list',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const BucketListScreen(),
      ),
      GoRoute(
        path: '/itinerary',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.navItinerary,
          child: const ItineraryScreen(),
        ),
      ),
      GoRoute(
        path: '/group-planner',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.groupPlannerTitle,
          child: const GroupPlannerLandingScreen(),
        ),
      ),
      GoRoute(
        path: '/group-planner/create',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.groupPlannerCreateTripTitle,
          child: const GroupPlannerCreateTripScreen(),
        ),
      ),
      GoRoute(
        path: '/group-trip/:tripId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final raw = state.pathParameters['tripId'] ?? '';
          return FullscreenToolScaffold(
            subtitle: context.l10n.groupPlannerTitle,
            child: GroupTripRouteScreen(rawTripRef: raw),
          );
        },
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
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.tipAppBarSubtitle,
          child: const TipCalculatorScreen(),
        ),
      ),
      GoRoute(
        path: '/size-converter',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.sizeConverterAppBarSubtitle,
          child: const SizeConverterScreen(),
        ),
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
      GoRoute(
        path: '/dual-clock-widget',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.dualClockScreenTitle,
          child: const WidgetInstructionScreen(),
        ),
      ),
      GoRoute(
        path: '/dual-clock-widget/configure',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.dualClockConfigTitle,
          child: const DualCitySelectionScreen(),
        ),
      ),
      GoRoute(
        path: '/our-apps',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FullscreenToolScaffold(
          subtitle: context.l10n.ourAppsScreenTitle,
          child: const OurAppsScreen(),
        ),
      ),
    ],
  );
}
