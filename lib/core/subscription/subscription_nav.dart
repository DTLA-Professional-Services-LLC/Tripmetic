import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import 'tripmetic_pro_entitlement.dart';

/// GoRouter [location] gate (e.g. `/units`) — same entitlement rules as the main shell.
Future<void> navigateIfProRoute(BuildContext context, String location) async {
  try {
    var customerInfo = await Purchases.getCustomerInfo();
    if (!context.mounted) return;

    if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
      context.push(location);
      return;
    }

    await RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
    if (!context.mounted) return;

    customerInfo = await Purchases.getCustomerInfo();
    if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
      if (context.mounted) context.push(location);
    }
  } catch (e, st) {
    assert(() {
      debugPrint('navigateIfProRoute: $e\n$st');
      return true;
    }());
  }
}

/// For bottom navigation and other flows that do not push a new [Widget].
Future<bool> ensureProOrShowPaywall(BuildContext context) async {
  try {
    var customerInfo = await Purchases.getCustomerInfo();
    if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
      return true;
    }

    await RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
    if (!context.mounted) return false;

    customerInfo = await Purchases.getCustomerInfo();
    return TripmeticProEntitlement.isUnlocked(customerInfo);
  } catch (e, st) {
    assert(() {
      debugPrint('ensureProOrShowPaywall: $e\n$st');
      return true;
    }());
    return false;
  }
}
