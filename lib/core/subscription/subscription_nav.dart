import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../navigation/main_nav_intent_provider.dart';
import '../navigation/nav_feature_ids.dart';
import '../navigation/navigation_preferences_provider.dart';
import '../navigation/tripmetic_home_navigation.dart';
import 'revenue_cat_sdk_state.dart';
import 'tripmetic_pro_entitlement.dart';

const Duration _kPurchasesNavTimeout = Duration(seconds: 8);

/// Opens a catalog feature: Pro tools navigate through; free users see the soft
/// glass overlay on the destination instead of a blocking paywall.
Future<void> openNavFeature(BuildContext context, WidgetRef ref, String featureId) async {
  // Dashboard is the home tab itself (no pushed route). Switch the bottom-nav
  // to its pinned slot if present, otherwise just route back to `/` and let
  // [MainScreen] render whatever pins the user has. We deliberately do NOT
  // auto-pin Dashboard for the user — they can re-pin it from the More menu.
  if (featureId == NavFeatureIds.dashboard) {
    final pins = ref.read(navigationPreferencesProvider).value;
    if (pins != null && pins.length >= 4) {
      final idx = pins.indexOf(NavFeatureIds.dashboard);
      if (idx >= 0 && idx < 4) {
        ref.read(currentTabIndexProvider.notifier).state = idx;
      }
    }
    if (context.mounted) context.go('/');
    return;
  }

  final path = NavFeatureRoutes.routeFor(featureId);
  if (path == null) {
    goTripmeticHome(context, ref, selectFeatureId: featureId);
    return;
  }
  if (context.mounted) context.push(path);
}

/// Resolves a GoRouter [location] (e.g. `/units`) to a feature when possible.
Future<void> openNavFeatureFromPath(BuildContext context, WidgetRef ref, String location) async {
  final id = NavFeatureRoutes.idForPath(location);
  if (id != null) {
    await openNavFeature(context, ref, id);
    return;
  }
  if (context.mounted) context.push(location);
}

/// Legacy helper — prefer [openNavFeatureFromPath] with [WidgetRef].
Future<void> navigateIfProRoute(BuildContext context, String location) async {
  if (!revenueCatSdkConfigured) {
    if (context.mounted) context.push(location);
    return;
  }
  try {
    final customerInfo =
        await Purchases.getCustomerInfo().timeout(_kPurchasesNavTimeout);
    if (!context.mounted) return;

    if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
      context.push(location);
      return;
    }
    if (context.mounted) context.go('/paywall');
  } catch (e, st) {
    debugPrint('navigateIfProRoute: $e\n$st');
    if (context.mounted) context.go('/paywall');
  }
}

/// For bottom navigation and other flows that do not push a new [Widget].
Future<bool> ensureProOrShowPaywall(BuildContext context) async {
  if (!revenueCatSdkConfigured) {
    return true;
  }
  try {
    final customerInfo =
        await Purchases.getCustomerInfo().timeout(_kPurchasesNavTimeout);
    if (!context.mounted) return false;
    if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
      return true;
    }
    context.go('/paywall');
    return false;
  } catch (e, st) {
    debugPrint('ensureProOrShowPaywall: $e\n$st');
    if (context.mounted) context.go('/paywall');
    return false;
  }
}
