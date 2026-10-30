import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'firestore_lifetime_access_provider.dart';
import 'pro_test_override_provider.dart';
import 'revenue_cat_sdk_state.dart';
import 'tripmetic_pro_entitlement.dart';

const Duration _kCustomerInfoTimeout = Duration(seconds: 12);

/// In-memory [CustomerInfo] used when RevenueCat is unavailable (e.g. configure failed).
/// Entitlements are empty so the user is treated as non‑subscriber.
final CustomerInfo revenueCatUnavailableCustomerInfo = CustomerInfo(
  const EntitlementInfos({}, {}),
  const {},
  const [],
  const [],
  const [],
  '1970-01-01T00:00:00.000Z',
  r'$RCAnonymousID:unavailable',
  const {},
  '1970-01-01T00:00:00.000Z',
);

/// Latest [CustomerInfo]; updates when purchases restore or renew.
/// [Purchases.configure] runs during app bootstrap.
final customerInfoProvider = AsyncNotifierProvider<CustomerInfoNotifier, CustomerInfo>(
  CustomerInfoNotifier.new,
);

class CustomerInfoNotifier extends AsyncNotifier<CustomerInfo> {
  CustomerInfoUpdateListener? _listener;

  @override
  Future<CustomerInfo> build() async {
    ref.onDispose(_teardown);

    if (!revenueCatSdkConfigured) {
      debugPrint(
        'RevenueCat: SDK not configured — using offline free-tier customer state.',
      );
      return revenueCatUnavailableCustomerInfo;
    }

    final CustomerInfo initial;
    try {
      initial = await Purchases.getCustomerInfo().timeout(_kCustomerInfoTimeout);
    } on PlatformException catch (e, st) {
      if (revenueCatShouldDegradeGracefully(e)) {
        debugLogRevenueCatGraceful('customerInfoProvider.build (configurationError)', e, st);
        return revenueCatUnavailableCustomerInfo;
      }
      rethrow;
    }
    _listener = (CustomerInfo info) {
      state = AsyncData(info);
    };
    Purchases.addCustomerInfoUpdateListener(_listener!);
    return initial;
  }

  void _teardown() {
    if (_listener != null) {
      Purchases.removeCustomerInfoUpdateListener(_listener!);
      _listener = null;
    }
  }

  /// Apply [CustomerInfo] already fetched (e.g. from [Purchases.logIn]).
  void apply(CustomerInfo info) {
    state = AsyncData(info);
  }

  /// Force-refresh from RevenueCat servers (e.g. after login / admin grant).
  Future<void> sync() async {
    if (!revenueCatSdkConfigured) {
      state = AsyncData(revenueCatUnavailableCustomerInfo);
      return;
    }
    try {
      state = const AsyncLoading();
      // Promotional grants from the admin console / website need a cache bust
      // or the device can keep serving pre-grant CustomerInfo.
      await Purchases.invalidateCustomerInfoCache();
      final info = await Purchases.getCustomerInfo().timeout(_kCustomerInfoTimeout);
      state = AsyncData(info);
    } on PlatformException catch (e, st) {
      if (revenueCatShouldDegradeGracefully(e)) {
        debugLogRevenueCatGraceful('customerInfoProvider.sync (configurationError)', e, st);
        state = AsyncData(revenueCatUnavailableCustomerInfo);
        return;
      }
      debugPrint('sync customer info failed: $e\n$st');
      state = AsyncError(e, st);
    } catch (e, st) {
      debugPrint('sync customer info failed: $e\n$st');
      state = AsyncError(e, st);
    }
  }
}

/// `true` when the **Tripmetic Pro** entitlement is active.
///
/// Honors the local [proTestOverrideProvider] first so internal testers can
/// validate the Pro UX on a single device without a working RevenueCat
/// configuration. Also unlocks when Firestore `lifetime_access` is set (admin
/// / redeem grants), so Settings stays in sync with the admin console even if
/// RevenueCat cache/identity lags. Release builds never honor the override.
final isTripmeticProProvider = Provider<bool>((ref) {
  final override = kReleaseMode
      ? false
      : (ref.watch(proTestOverrideProvider).valueOrNull ?? false);
  if (override) return true;
  final lifetime = ref.watch(firestoreLifetimeAccessProvider).valueOrNull ?? false;
  if (lifetime) return true;
  final async = ref.watch(customerInfoProvider);
  return async.maybeWhen(
    data: (info) => TripmeticProEntitlement.isUnlocked(info),
    orElse: () => false,
  );
});
