import 'package:purchases_flutter/purchases_flutter.dart';

/// RevenueCat identifiers for Tripmetic Pro.
///
/// [id] must match the **Entitlement** identifier in RevenueCat exactly
/// (Product catalog → Entitlements). It is used by
/// [RevenueCatUI.presentPaywallIfNeeded].
///
/// [monthlyStoreProductId] is the Play / App Store **subscription product id**
/// (same string as in each store and in RevenueCat → Products).
abstract final class TripmeticProEntitlement {
  /// Entitlement identifier in RevenueCat (not the store product id).
  static const String id = 'Tripmetic Pro';

  static const String monthlyStoreProductId = 'tripmetic_pro_monthly';

  /// Alternate entitlement ids seen in past dashboard setups.
  static const List<String> legacyEntitlementIds = [
    'tripmetic_pro_monthly',
    'Tripmatic Pro',
    'tripmatic_pro_monthly',
  ];

  static bool isUnlocked(CustomerInfo info) {
    if (info.entitlements.all[id]?.isActive == true) return true;
    for (final legacyId in legacyEntitlementIds) {
      if (info.entitlements.all[legacyId]?.isActive == true) {
        return true;
      }
    }
    return info.activeSubscriptions.contains(monthlyStoreProductId);
  }
}
