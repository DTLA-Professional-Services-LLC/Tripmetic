import '../domain/crypto_rates_snapshot.dart';

/// Remote stream of crypto USD-per-unit snapshots (e.g. Firestore).
abstract class RemoteCryptoRatesDataSource {
  Stream<CryptoRatesSnapshot> watchRates();
}
