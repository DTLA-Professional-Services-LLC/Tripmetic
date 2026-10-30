import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Set to `true` only after [Purchases.configure] succeeds during app bootstrap.
bool revenueCatSdkConfigured = false;

bool _purchasesErrorCodeIsConfiguration(PlatformException e) {
  try {
    return PurchasesErrorHelper.getErrorCode(e) ==
        PurchasesErrorCode.configurationError;
  } catch (_) {
    return false;
  }
}

/// Configuration / setup failures (e.g. RevenueCat error 23) that should not
/// block the app — log only and treat the user as non‑subscriber.
bool revenueCatShouldDegradeGracefully(Object error) {
  if (error is PlatformException) {
    return _purchasesErrorCodeIsConfiguration(error);
  }
  return false;
}

void debugLogRevenueCatGraceful(String context, Object error, StackTrace stack) {
  debugPrint('RevenueCat graceful ($context): $error\n$stack');
}
