import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:timezone/data/latest.dart' as tz_data;

import 'core/constants/app_brand.dart';
import 'core/subscription/revenue_cat_sdk_state.dart';
import 'tripmetic_app.dart';
import 'features/crypto/application/crypto_providers.dart';
import 'features/currency/application/currency_providers.dart';
import 'features/map/domain/saved_location.dart';
import 'features/trip/application/trip_providers.dart';
import 'features/mindmap/application/mind_map_providers.dart';
import 'features/vault/application/vault_providers.dart';

/// RevenueCat **public** SDK key for **Google Play** (RevenueCat → Project → API keys).
const _revenueCatGooglePlayPublicSdkKey = 'goog_TMvOXRhuUqLSLkxiJPGicxpIyRR';

/// RevenueCat **public** SDK key for **Apple** (starts with `appl_`).
const _revenueCatApplePublicSdkKey = 'appl_MMsoOEadRnZGIASFaNzmrOzOEwJ';

Future<void> _configureRevenueCat() async {
  if (kIsWeb) return;

  revenueCatSdkConfigured = false;

  final String apiKey;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      apiKey = _revenueCatGooglePlayPublicSdkKey;
      break;
    case TargetPlatform.iOS:
      apiKey = _revenueCatApplePublicSdkKey;
      break;
    default:
      return;
  }

  try {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    await Purchases.configure(PurchasesConfiguration(apiKey));
    revenueCatSdkConfigured = true;
  } on PlatformException catch (e, st) {
    if (revenueCatShouldDegradeGracefully(e)) {
      debugLogRevenueCatGraceful('configure (configurationError)', e, st);
    } else {
      debugLogRevenueCatGraceful('configure (PlatformException)', e, st);
    }
  } catch (e, st) {
    debugLogRevenueCatGraceful('configure', e, st);
  }
}

Future<void> _initializeAppServices(ProviderContainer container) async {
  await _configureRevenueCat();

  await Firebase.initializeApp();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(kSavedLocationTypeId)) {
    Hive.registerAdapter(SavedLocationAdapter());
  }
  await Hive.openBox<SavedLocation>(kSavedLocationsBoxName);
  tz_data.initializeTimeZones();

  await Future.wait([
    container.read(currencyRepositoryReadyProvider.future),
    container.read(cryptoRatesRepositoryReadyProvider.future),
    container.read(tripHiveStoreReadyProvider.future),
    container.read(mindMapHiveStoreReadyProvider.future),
    container.read(vaultHiveStoreReadyProvider.future),
  ]);

  container.read(mindMapProvider);
}

/// Builds the root widget after Firebase, RevenueCat, Hive, and repository warm-up.
Future<Widget> createTripmeticRoot() async {
  final container = ProviderContainer();
  try {
    await _initializeAppServices(container);
    return UncontrolledProviderScope(
      container: container,
      child: TripmeticApp(applicationTitle: AppBrand.applicationTitle),
    );
  } catch (e, st) {
    container.dispose();
    Error.throwWithStackTrace(e, st);
  }
}
