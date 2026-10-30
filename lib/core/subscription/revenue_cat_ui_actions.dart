import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_ui_flutter/views/customer_center_view_method_handler.dart';

import 'revenue_cat_sdk_state.dart';
import 'tripmetic_pro_entitlement.dart';

/// Single-plan offering: only the monthly SKU is forwarded to the paywall UI.
Offering _offeringMonthlyOnly(Offering source) {
  final monthly = source.monthly ??
      source.availablePackages.firstWhereOrNull(
        (p) =>
            p.packageType == PackageType.monthly ||
            p.storeProduct.identifier ==
                TripmeticProEntitlement.monthlyStoreProductId,
      );
  if (monthly == null) return source;
  return Offering(
    source.identifier,
    source.serverDescription,
    source.metadata,
    [monthly],
    monthly: monthly,
  );
}

/// Presents the configured RevenueCat Paywall (dashboard → Paywalls).
///
/// See: https://www.revenuecat.com/docs/tools/paywalls
Future<PaywallResult> presentTripmeticPaywall() async {
  if (!revenueCatSdkConfigured) {
    debugPrint('RevenueCat: presentTripmeticPaywall skipped — SDK not configured.');
    return PaywallResult.error;
  }
  try {
    final offerings = await Purchases.getOfferings();
    final current = offerings.current;
    if (current == null) {
      debugPrint(
        'RevenueCat: no current offering — add an Offering in the dashboard and attach your paywall.',
      );
      return PaywallResult.error;
    }
    return RevenueCatUI.presentPaywall(
      offering: _offeringMonthlyOnly(current),
    );
  } on PlatformException catch (e, st) {
    if (revenueCatShouldDegradeGracefully(e)) {
      debugLogRevenueCatGraceful('getOfferings (configurationError)', e, st);
    } else {
      debugLogRevenueCatGraceful('getOfferings (PlatformException)', e, st);
    }
    return PaywallResult.error;
  } catch (e, st) {
    debugPrint('presentTripmeticPaywall: $e\n$st');
    return PaywallResult.error;
  }
}

/// Only shows the paywall if [TripmeticProEntitlement.id] is not active.
Future<PaywallResult> presentTripmeticPaywallIfNeeded() async {
  if (!revenueCatSdkConfigured) {
    debugPrint('RevenueCat: presentPaywallIfNeeded skipped — SDK not configured.');
    return PaywallResult.notPresented;
  }
  try {
    // Avoid hard-failing on entitlement-id drift in RevenueCat dashboard; we
    // gate access elsewhere via CustomerInfo + isUnlocked().
    return await presentTripmeticPaywall();
  } on PlatformException catch (e, st) {
    if (revenueCatShouldDegradeGracefully(e)) {
      debugLogRevenueCatGraceful('presentPaywallIfNeeded (configurationError)', e, st);
    } else {
      debugLogRevenueCatGraceful('presentPaywallIfNeeded (PlatformException)', e, st);
    }
    return PaywallResult.error;
  } catch (e, st) {
    debugPrint('presentTripmeticPaywallIfNeeded: $e\n$st');
    return PaywallResult.error;
  }
}

/// Subscription management / restore / help — RevenueCat Customer Center.
///
/// See: https://www.revenuecat.com/docs/tools/customer-center
Future<void> presentTripmeticCustomerCenter({
  CustomerCenterRestoreCompleted? onRestoreCompleted,
  CustomerCenterRestoreFailed? onRestoreFailed,
}) async {
  if (!revenueCatSdkConfigured) {
    debugPrint('RevenueCat: Customer Center skipped — SDK not configured.');
    return;
  }
  try {
    await RevenueCatUI.presentCustomerCenter(
      onRestoreCompleted: onRestoreCompleted,
      onRestoreFailed: onRestoreFailed,
    );
  } on PlatformException catch (e, st) {
    if (revenueCatShouldDegradeGracefully(e)) {
      debugLogRevenueCatGraceful('presentCustomerCenter (configurationError)', e, st);
    } else {
      debugLogRevenueCatGraceful('presentCustomerCenter (PlatformException)', e, st);
    }
  } catch (e, st) {
    debugPrint('presentTripmeticCustomerCenter: $e\n$st');
  }
}
