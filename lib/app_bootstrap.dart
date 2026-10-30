import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:home_widget/home_widget.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'core/config/app_secrets.dart';
import 'core/config/firebase_config.dart';
import 'core/constants/app_brand.dart';
import 'core/demo/apply_tripmetic_demo_seeds.dart';
import 'core/notifications/fcm_service.dart';
import 'core/subscription/revenue_cat_identity.dart';
import 'core/subscription/revenue_cat_sdk_state.dart';
import 'core/subscription/subscription_providers.dart';
import 'features/auth/application/user_profile_sync.dart';
import 'services/currency_widget_background_callback.dart';
import 'services/widget_service.dart';
import 'tripmetic_app.dart';
import 'features/crypto/application/crypto_providers.dart';
import 'features/currency/application/currency_providers.dart';
import 'features/map/domain/saved_location.dart';
import 'features/trip/application/trip_providers.dart';
import 'features/mindmap/application/mind_map_providers.dart';
import 'features/vault/application/vault_providers.dart';
import 'features/bucket_list/application/bucket_list_provider.dart';
import 'features/scheduler/application/scheduler_notifier.dart';
import 'features/scheduler/data/scheduler_prefs_store.dart';

/// RevenueCat **public** SDK key for **Google Play** (RevenueCat → Project → API keys).
///
/// Injected at build time with `--dart-define=REVENUECAT_GOOGLE_KEY=goog.…`.
/// See [AppSecrets] for the full list of supported defines.
const _revenueCatGooglePlayPublicSdkKey = AppSecrets.revenueCatGoogleKey;

/// RevenueCat **public** SDK key for **Apple** (starts with `appl_`).
///
/// Injected at build time with `--dart-define=REVENUECAT_APPLE_KEY=appl.…`.
const _revenueCatApplePublicSdkKey = AppSecrets.revenueCatAppleKey;

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

  // Placeholder means "no key was injected at build time". Skip the SDK
  // entirely so the app stays in a usable (non-Pro) state instead of
  // calling RevenueCat with a dummy credential.
  if (!AppSecrets.isConfigured(apiKey)) {
    debugLogRevenueCatGraceful(
      'configure (unconfiguredApiKey)',
      StateError(
        'RevenueCat public API key was not provided at build time. '
        'Pass --dart-define=REVENUECAT_${isAndroid ? 'GOOGLE' : 'APPLE'}_KEY=…',
      ),
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

  if (isIos && !apiKey.startsWith('appl_')) {
    debugLogRevenueCatGraceful(
      'configure (unexpectedIosKeyPrefix)',
      StateError('Apple RevenueCat key must start with "appl_".'),
      StackTrace.current,
    );
    return;
  }

  try {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    await Purchases.configure(PurchasesConfiguration(apiKey));
    revenueCatSdkConfigured = true;
    debugPrint(
      'RevenueCat configure OK (${isAndroid ? 'android' : 'ios'})',
    );
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

/// Minimal work required before the first real UI frame.
Future<void> _initializeAppServices(ProviderContainer container) async {
  await WidgetService.initIosAppGroup();

  // Parallelize independent SDK inits (do not await offerings / FCM here).
  await Future.wait<void>([
    _configureRevenueCat(),
    FirebaseConfig.initialize(),
  ]);

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(kSavedLocationTypeId)) {
    Hive.registerAdapter(SavedLocationAdapter());
  }
  tz_data.initializeTimeZones();

  await Future.wait<void>([
    Hive.openBox<SavedLocation>(kSavedLocationsBoxName),
    openSchedulerPrefsBox(),
    container.read(currencyRepositoryReadyProvider.future),
    container.read(cryptoRatesRepositoryReadyProvider.future),
    container.read(tripHiveStoreReadyProvider.future),
    container.read(mindMapHiveStoreReadyProvider.future),
    container.read(vaultHiveStoreReadyProvider.future),
    container.read(bucketListHiveStoreReadyProvider.future),
  ]);

  // Scheduler prefs are local; finish before widgets that read it.
  await container.read(schedulerProvider.future);

  WidgetService.currencyWidgetRefreshHandler = () => WidgetService.performCurrencyWidgetRefresh(
        repo: container.read(currencyRepositoryProvider),
      );

  container.read(mindMapProvider);
}

/// Network / push / widget warm-up after the UI is already showing.
Future<void> _postLaunchWarmup(ProviderContainer container) async {
  // Offerings are only needed for paywalls — never block startup.
  if (revenueCatSdkConfigured) {
    unawaited(() async {
      try {
        final offerings = await Purchases.getOfferings();
        debugPrint(
          'RevenueCat offerings ready '
          'current=${offerings.current?.identifier ?? 'none'} '
          'total=${offerings.all.length}',
        );
      } catch (e, st) {
        debugLogRevenueCatGraceful('postLaunch (getOfferings)', e, st);
      }
    }());
  }

  final existingUser = FirebaseAuth.instance.currentUser;
  if (existingUser != null) {
    unawaited(() async {
      await revenueCatLogIn(existingUser.uid);
      try {
        await container.read(customerInfoProvider.notifier).sync();
      } catch (_) {
        // Non-fatal: Settings / Pro gates refresh on next CustomerInfo update.
      }
      await ensureUserProfileDoc(user: existingUser);
    }());
  }

  unawaited(() async {
    await FcmService.initialize();
    if (FirebaseAuth.instance.currentUser != null) {
      await FcmService.subscribeAllUsers();
    }
  }());

  unawaited(WidgetService.registerInteractivityCallback(currencyWidgetBackgroundCallback));

  // Seed widgets from cache first; network refresh is inside bootstrap helper.
  unawaited(WidgetService.bootstrapAndroidWidget(container));

  if (Platform.isAndroid) {
    unawaited(() async {
      final launchUri = await HomeWidget.initiallyLaunchedFromHomeWidget();
      final launchRoute =
          launchUri != null ? WidgetService.routePathForExternalUri(launchUri) : null;
      if (launchRoute == '/currency-widget/refresh') {
        await WidgetService.performCurrencyWidgetRefresh(
          repo: container.read(currencyRepositoryProvider),
        );
      }
    }());
  }

  unawaited(applyTripmeticDemoSeeds(container));
}

/// Builds the root widget after local SDKs + Hive are ready (network deferred).
Future<Widget> createTripmeticRoot() async {
  final container = ProviderContainer();
  try {
    await _initializeAppServices(container);
    unawaited(_postLaunchWarmup(container));
    return UncontrolledProviderScope(
      container: container,
      child: TripmeticApp(applicationTitle: AppBrand.applicationTitle),
    );
  } catch (e, st) {
    container.dispose();
    Error.throwWithStackTrace(e, st);
  }
}
