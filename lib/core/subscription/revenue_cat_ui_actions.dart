import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_ui_flutter/views/customer_center_view_method_handler.dart';

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
  try {
    final offerings = await Purchases.getOfferings();
    final current = offerings.current;
    if (current == null) {
      assert(() {
        debugPrint(
          'RevenueCat: no current offering — add an Offering in the dashboard and attach your paywall.',
        );
        return true;
      }());
      return PaywallResult.error;
    }
    return RevenueCatUI.presentPaywall(
      offering: _offeringMonthlyOnly(current),
    );
  } catch (e, st) {
    assert(() {
      debugPrint('presentTripmeticPaywall: $e\n$st');
      return true;
    }());
    return PaywallResult.error;
  }
}

/// Only shows the paywall if [TripmeticProEntitlement.id] is not active.
Future<PaywallResult> presentTripmeticPaywallIfNeeded() {
  return RevenueCatUI.presentPaywallIfNeeded(TripmeticProEntitlement.id);
}

/// Subscription management / restore / help — RevenueCat Customer Center.
///
/// See: https://www.revenuecat.com/docs/tools/customer-center
Future<void> presentTripmeticCustomerCenter({
  CustomerCenterRestoreCompleted? onRestoreCompleted,
  CustomerCenterRestoreFailed? onRestoreFailed,
}) async {
  try {
    await RevenueCatUI.presentCustomerCenter(
      onRestoreCompleted: onRestoreCompleted,
      onRestoreFailed: onRestoreFailed,
    );
  } catch (e, st) {
    assert(() {
      debugPrint('presentTripmeticCustomerCenter: $e\n$st');
      return true;
    }());
  }
}
