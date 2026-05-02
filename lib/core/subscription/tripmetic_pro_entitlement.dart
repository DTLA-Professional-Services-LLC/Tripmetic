import 'package:purchases_flutter/purchases_flutter.dart';

/// RevenueCat identifiers for the single monthly Tripmetic Pro plan.
///
/// [id] is used with [CustomerInfo.entitlements] and
/// [RevenueCatUI.presentPaywallIfNeeded] — it must match the **Entitlement**
/// identifier in RevenueCat exactly. Rename the entitlement to
/// `tripmetic_pro_monthly` if it is still `Tripmatic Pro`, or change this
/// constant to match your dashboard.
///
/// [monthlyStoreProductId] is the Play/App Store product id for the monthly
/// subscription (same string you use in RevenueCat → Products).
abstract final class TripmeticProEntitlement {
  static const String id = 'tripmetic_pro_monthly';

  static const String monthlyStoreProductId = 'tripmetic_pro_monthly';

  /// Older RevenueCat dashboards used this entitlement id for the same plan.
  static const String legacyEntitlementId = 'Tripmetic Pro';

  /// True when the monthly entitlement is active or the monthly SKU is in
  /// [CustomerInfo.activeSubscriptions] (defensive for mis-synced metadata).
  static bool isUnlocked(CustomerInfo info) {
    if (info.entitlements.all[id]?.isActive == true) return true;
    if (info.entitlements.all[legacyEntitlementId]?.isActive == true) {
      return true;
    }
    return info.activeSubscriptions.contains(monthlyStoreProductId);
  }
}
