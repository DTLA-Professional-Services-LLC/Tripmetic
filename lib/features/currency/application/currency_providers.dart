import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/sync/composite_fiat_rates_data_source.dart';
import '../../../core/data/sync/remote_rates_data_source.dart';
import '../data/currency_repository.dart';
import '../domain/exchange_rate_snapshot.dart';

final remoteRatesDataSourceProvider = Provider<RemoteRatesDataSource>(
  (ref) => CompositeFiatRatesDataSource(),
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

/// Pull-to-refresh / manual refresh — bypasses the 12-hour TTL.
Future<void> refreshExchangeRates(WidgetRef ref) async {
  await ref.read(currencyRepositoryProvider).refreshFromNetwork();
}

/// Deletes cached FX rows then forces a fresh server snapshot (fixes stale Hive TTL).
Future<ExchangeRateSnapshot?> refreshExchangeRatesClearingCache(WidgetRef ref) {
  return ref.read(currencyRepositoryProvider).clearRateCacheAndRefresh();
}

/// Budget tab / long-running session — refresh only when Hive cache is older than TTL.
Future<void> ensureExchangeRatesFreshIfNeeded(WidgetRef ref) async {
  await ref.read(currencyRepositoryProvider).ensureFreshRatesIfNeeded();
}
