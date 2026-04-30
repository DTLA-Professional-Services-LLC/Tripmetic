import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/sync/firestore_crypto_rates_data_source.dart';
import '../data/crypto_catalog.dart';
import '../data/crypto_rates_repository.dart';
import '../data/remote_crypto_rates_data_source.dart';
import '../domain/crypto_rates_snapshot.dart';

final remoteCryptoRatesDataSourceProvider = Provider<RemoteCryptoRatesDataSource>(
  (ref) => FirestoreRemoteCryptoRatesDataSource(),
);

final cryptoRatesRepositoryProvider = Provider<CryptoRatesRepository>((ref) {
  final repo = CryptoRatesRepository(ref.watch(remoteCryptoRatesDataSourceProvider));
  ref.onDispose(() {
    repo.dispose();
  });
  return repo;
});

final cryptoRatesRepositoryReadyProvider = FutureProvider<void>((ref) async {
  await ref.watch(cryptoRatesRepositoryProvider).open();
});

final cryptoRatesStreamProvider = StreamProvider<CryptoRatesSnapshot>((ref) {
  ref.watch(cryptoRatesRepositoryReadyProvider);
  return ref.watch(cryptoRatesRepositoryProvider).watchRates();
});

/// USD value of 1.0 unit of each symbol (Firestore + Hive fallback to catalog).
final cryptoUsdPerCoinProvider = Provider<Map<String, double>>((ref) {
  final async = ref.watch(cryptoRatesStreamProvider);
  return async.maybeWhen(
    data: (s) => s.rates,
    orElse: () => cryptoRatesMap(),
  );
});
