import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripmetic/tripmetic_app.dart';
import 'package:tripmetic/core/data/sync/remote_rates_data_source.dart';
import 'package:tripmetic/features/crypto/application/crypto_providers.dart';
import 'package:tripmetic/features/crypto/data/crypto_catalog.dart';
import 'package:tripmetic/features/crypto/data/remote_crypto_rates_data_source.dart';
import 'package:tripmetic/features/crypto/domain/crypto_rates_snapshot.dart';
import 'package:tripmetic/features/currency/application/currency_providers.dart';
import 'package:tripmetic/features/currency/domain/exchange_rate_snapshot.dart';
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

    final container = ProviderContainer(
      overrides: [
        remoteRatesDataSourceProvider.overrideWithValue(MockRemoteRatesDataSource()),
        remoteCryptoRatesDataSourceProvider.overrideWithValue(_TestMockCryptoRemote()),
        exchangeRatesStreamProvider.overrideWith(
          (ref) => Stream.value(ExchangeRateSnapshot.defaults()),
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

    expect(find.text('EXCHANGE'), findsOneWidget);
  });
}
