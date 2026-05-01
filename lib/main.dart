import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:timezone/data/latest.dart' as tz_data;

import 'core/constants/app_brand.dart';
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
/// Prefer `--dart-define=REVENUECAT_IOS_PUBLIC_API_KEY=appl_...` (e.g. Codemagic env var).
/// For a quick device install without dart-define, you may paste the same `appl_` value here.
const String _revenueCatApplePublicSdkKeyFromDefine = String.fromEnvironment(
  'REVENUECAT_IOS_PUBLIC_API_KEY',
);
const String _revenueCatApplePublicSdkKeyFallback = '';

Future<void> _configureRevenueCat() async {
  if (kIsWeb) return;

  await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);

  final String apiKey;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      apiKey = _revenueCatGooglePlayPublicSdkKey;
      break;
    case TargetPlatform.iOS:
      apiKey = _revenueCatApplePublicSdkKeyFromDefine.isNotEmpty
          ? _revenueCatApplePublicSdkKeyFromDefine
          : _revenueCatApplePublicSdkKeyFallback;
      if (apiKey.isEmpty) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('RevenueCat Apple API key missing'),
          ErrorDescription(
            'Use your Apple **public** SDK key from RevenueCat (starts with appl_). '
            'Pass --dart-define=REVENUECAT_IOS_PUBLIC_API_KEY=appl_... '
            'or paste it into _revenueCatApplePublicSdkKeyFallback in lib/main.dart. '
            'Configuring iOS with the Android (goog_...) key causes Error 23 and can fail store review.',
          ),
        ]);
      }
      break;
    default:
      return;
  }

  await Purchases.configure(PurchasesConfiguration(apiKey));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureRevenueCat();

  await Firebase.initializeApp();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(kSavedLocationTypeId)) {
    Hive.registerAdapter(SavedLocationAdapter());
  }
  await Hive.openBox<SavedLocation>(kSavedLocationsBoxName);
  tz_data.initializeTimeZones();

  final container = ProviderContainer();
  await Future.wait([
    container.read(currencyRepositoryReadyProvider.future),
    container.read(cryptoRatesRepositoryReadyProvider.future),
    container.read(tripHiveStoreReadyProvider.future),
    container.read(mindMapHiveStoreReadyProvider.future),
    container.read(vaultHiveStoreReadyProvider.future),
  ]);

  // Eagerly load mind map from Hive so the first frame never flashes a wrong snapshot.
  container.read(mindMapProvider);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: TripmeticApp(applicationTitle: AppBrand.applicationTitle),
    ),
  );
}
