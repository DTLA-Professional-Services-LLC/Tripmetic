import 'package:firebase_core/firebase_core.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable debug logs to see what RevenueCat is doing under the hood during testing
  await Purchases.setLogLevel(LogLevel.debug);

  // Initialize RevenueCat with the Android Google Play API Key
  PurchasesConfiguration configuration = PurchasesConfiguration(
    'goog_TMvOXRhuUqLSLkxiJPGicxpIyRR',
  );
  await Purchases.configure(configuration);

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
