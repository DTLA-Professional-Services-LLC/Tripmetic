import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'tripmetic_pro_entitlement.dart';

const Duration _kPurchasesNavTimeout = Duration(seconds: 8);

/// GoRouter [location] gate (e.g. `/units`) — same entitlement rules as the main shell.
Future<void> navigateIfProRoute(BuildContext context, String location) async {
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
