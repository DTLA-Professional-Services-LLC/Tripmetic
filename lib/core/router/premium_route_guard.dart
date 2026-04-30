import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../subscription/tripmetic_pro_entitlement.dart';

/// Only the dedicated paywall route is reachable without an active subscription.
const Set<String> publicRoutesWithoutSubscription = {'/paywall'};

/// Blocks navigation to any feature unless the user has an active subscription.
FutureOr<String?> redirectPremiumTools(
  BuildContext context,
  GoRouterState state,
) async {
  if (publicRoutesWithoutSubscription.contains(state.uri.path)) {
    return null;
  }

  try {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
      return null;
    } else {
      await RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
      customerInfo = await Purchases.getCustomerInfo();
      if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
        return null;
      }
    }
  } catch (e) {
    debugPrint('Entitlement check failed: $e');
  }
  return '/paywall';
}
