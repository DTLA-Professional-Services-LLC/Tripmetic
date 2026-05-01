import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../subscription/tripmetic_pro_entitlement.dart';

/// Only the dedicated paywall route is reachable without an active subscription.
const Set<String> publicRoutesWithoutSubscription = {'/paywall'};

/// Sends non‑subscribers to [/paywall]. Do **not** call
/// [RevenueCatUI.presentPaywallIfNeeded] here — GoRouter runs this redirect
/// before the navigator is ready to host modals, which can freeze the app on
/// the launch screen. The paywall route shows [PaywallView] instead.
FutureOr<String?> redirectPremiumTools(
  BuildContext context,
  GoRouterState state,
) async {
  if (publicRoutesWithoutSubscription.contains(state.uri.path)) {
    return null;
  }

  try {
    final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    if (TripmeticProEntitlement.isUnlocked(customerInfo)) {
      return null;
    }
  } catch (e) {
    debugPrint('Entitlement check failed: $e');
  }
  return '/paywall';
}
