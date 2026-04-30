import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/sync/firestore_fiat_rates_data_source.dart';
import '../../../core/data/sync/remote_rates_data_source.dart';
import '../data/currency_repository.dart';
import '../domain/exchange_rate_snapshot.dart';

final remoteRatesDataSourceProvider = Provider<RemoteRatesDataSource>(
  (ref) => FirestoreRemoteRatesDataSource(),
);

final currencyRepositoryProvider = Provider<CurrencyRepository>((ref) {
  final repo = CurrencyRepository(ref.watch(remoteRatesDataSourceProvider));
  ref.onDispose(() {
    repo.dispose();
  });
  return repo;
});

final currencyRepositoryReadyProvider = FutureProvider<void>((ref) async {
  await ref.watch(currencyRepositoryProvider).open();
});

final exchangeRatesStreamProvider = StreamProvider<ExchangeRateSnapshot>((ref) {
  ref.watch(currencyRepositoryReadyProvider);
  return ref.watch(currencyRepositoryProvider).watchRates();
});
