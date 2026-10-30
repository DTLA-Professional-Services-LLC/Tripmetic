import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmetic/tripmetic_app.dart';
import 'package:tripmetic/core/data/sync/remote_rates_data_source.dart';
import 'package:tripmetic/core/navigation/nav_feature_ids.dart';
import 'package:tripmetic/core/navigation/navigation_preferences_provider.dart';
import 'package:tripmetic/features/crypto/application/crypto_providers.dart';
import 'package:tripmetic/features/crypto/data/crypto_catalog.dart';
import 'package:tripmetic/features/crypto/data/remote_crypto_rates_data_source.dart';
import 'package:tripmetic/features/crypto/domain/crypto_rates_snapshot.dart';
import 'package:tripmetic/features/currency/application/currency_providers.dart';
import 'package:tripmetic/features/currency/domain/exchange_rate_snapshot.dart';
import 'package:tripmetic/features/map/domain/saved_location.dart';
import 'package:tripmetic/l10n/generated/app_localizations_en.dart';
import 'package:timezone/data/latest.dart' as tz_data;

class _TestMockCryptoRemote implements RemoteCryptoRatesDataSource {
  @override
  Stream<CryptoRatesSnapshot> watchRates() async* {
    yield CryptoRatesSnapshot(
      rates: cryptoRatesMap(),
      updatedAt: DateTime.now().toUtc(),
      isOffline: true,
    );
    await Future<void>.delayed(const Duration(days: 365));
  }
}

void main() {
  testWidgets('Currency tab renders', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    tz_data.initializeTimeZones();

    // The shell reads pinned tabs from SharedPreferences; without a mock the
    // provider never resolves and the tree stays on a loading spinner.
    SharedPreferences.setMockInitialValues(<String, Object>{});

    // Several pinned tabs read from Hive, so give it a temp directory.
    final Directory hiveDir = Directory.systemTemp.createTempSync('tripmetic_test');
    Hive.init(hiveDir.path);
    if (!Hive.isAdapterRegistered(kSavedLocationTypeId)) {
      Hive.registerAdapter(SavedLocationAdapter());
    }
    addTearDown(() async {
      await Hive.close();
      if (hiveDir.existsSync()) hiveDir.deleteSync(recursive: true);
    });

    final container = ProviderContainer(
      overrides: [
        remoteRatesDataSourceProvider.overrideWithValue(MockRemoteRatesDataSource()),
        remoteCryptoRatesDataSourceProvider.overrideWithValue(_TestMockCryptoRemote()),
        exchangeRatesStreamProvider.overrideWith(
          (ref) => Stream.value(ExchangeRateSnapshot.defaults()),
        ),
        // Pin the Currency tool so the shell renders [CurrencyTab].
        navigationPreferencesProvider.overrideWith(
          () => _PinnedCurrencyPreferences(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TripmeticApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Reference the localization source of truth instead of hardcoding the
    // label, so renaming the string can never break this test.
    expect(
      find.text(AppLocalizationsEn().exchangeHeader),
      findsOneWidget,
    );
  });
}

/// Overrides the persisted pin order so the Currency tool is the active tab.
class _PinnedCurrencyPreferences extends NavigationPreferencesNotifier {
  @override
  Future<List<String>> build() async => <String>[
        NavFeatureIds.currency,
        NavFeatureIds.dashboard,
        NavFeatureIds.units,
        NavFeatureIds.settings,
      ];
}
