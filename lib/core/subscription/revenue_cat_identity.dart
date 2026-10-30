import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'revenue_cat_sdk_state.dart';

/// Links the Firebase Auth uid to RevenueCat so web-granted entitlements resolve.
///
/// Returns the post-login [CustomerInfo] when available so callers can update
/// [customerInfoProvider] without a second round-trip.
Future<CustomerInfo?> revenueCatLogIn(String uid) async {
  if (!revenueCatSdkConfigured || uid.isEmpty) return null;
  try {
    final result = await Purchases.logIn(uid);
    return result.customerInfo;
  } on PlatformException catch (e, st) {
    debugLogRevenueCatGraceful('logIn', e, st);
    return null;
  } catch (e, st) {
    debugPrint('RevenueCat logIn failed: $e\n$st');
    return null;
  }
}

Future<void> revenueCatLogOut() async {
  if (!revenueCatSdkConfigured) return;
  try {
    await Purchases.logOut();
  } on PlatformException catch (e, st) {
    debugLogRevenueCatGraceful('logOut', e, st);
  } catch (e, st) {
    debugPrint('RevenueCat logOut failed: $e\n$st');
  }
}
