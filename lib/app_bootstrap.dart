import 'dart:io' show Platform;

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
import 'features/scheduler/application/scheduler_notifier.dart';
import 'features/scheduler/data/scheduler_prefs_store.dart';

/// RevenueCat **public** SDK key for **Google Play** (RevenueCat → Project → API keys).
const _revenueCatGooglePlayPublicSdkKey = 'goog_jwkBLnDKwsThQIxigLFAKMWuSGl';

/// RevenueCat **public** SDK key for **Apple** (starts with `appl_`).
const _revenueCatApplePublicSdkKey = 'appl_MMsoOEadRnZGIASFaNzmrOzOEwJ';

Future<void> _configureRevenueCat() async {
  if (kIsWeb) return;

  revenueCatSdkConfigured = false;

  final bool isAndroid = Platform.isAndroid;
  final bool isIos = Platform.isIOS;
  if (!isAndroid && !isIos) {
    return;
  }

  final String apiKey = isAndroid
      ? _revenueCatGooglePlayPublicSdkKey.trim()
      : _revenueCatApplePublicSdkKey.trim();

  if (apiKey.isEmpty) {
    debugLogRevenueCatGraceful(
      'configure (missingApiKey)',
      StateError('RevenueCat public API key is empty for platform.'),
      StackTrace.current,
    );
    return;
  }

  if (isAndroid && !apiKey.startsWith('goog_')) {
    debugLogRevenueCatGraceful(
      'configure (unexpectedAndroidKeyPrefix)',
      StateError('Android RevenueCat key must start with "goog_".'),
      StackTrace.current,
    );
    return;
  }

  try {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    await Purchases.configure(PurchasesConfiguration(apiKey));
    // Sanity-check the configuration once so we can gracefully disable Pro gates
    // instead of surfacing RevenueCat "configurationError" popups at runtime.
    final offerings = await Purchases.getOfferings();
    debugPrint(
      'RevenueCat bootstrap OK (${isAndroid ? 'android' : 'ios'}) '
      'currentOffering=${offerings.current?.identifier ?? 'none'} '
      'totalOfferings=${offerings.all.length}',
    );
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
  // Fully await RevenueCat configure before app services/UI that read purchase state.
  await _configureRevenueCat();

  await Firebase.initializeApp();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(kSavedLocationTypeId)) {
    Hive.registerAdapter(SavedLocationAdapter());
  }
  await Hive.openBox<SavedLocation>(kSavedLocationsBoxName);
  tz_data.initializeTimeZones();
  await openSchedulerPrefsBox();
  // Completes async scheduler load (Hive + JSON) before any widget reads the provider.
  await container.read(schedulerProvider.future);

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
