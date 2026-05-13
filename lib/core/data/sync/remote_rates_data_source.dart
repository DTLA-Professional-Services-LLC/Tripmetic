import '../../../features/currency/domain/exchange_rate_snapshot.dart';

/// Contract for a Firestore-backed (or other remote) stream of FX snapshots.
/// Swap [MockRemoteRatesDataSource] with a Firebase implementation that
/// maps Firestore documents into [ExchangeRateSnapshot].
///
/// After `flutterfire configure` and adding `firebase_core` / `cloud_firestore`,
/// implement `watchRates()` roughly as:
/// `FirebaseFirestore.instance.doc('config/fx').snapshots().map(ExchangeRateSnapshot.fromFirestore)`.
abstract class RemoteRatesDataSource {
  /// Emits whenever remote data changes. The mock emits once on subscribe.
  Stream<ExchangeRateSnapshot> watchRates();

  /// One-shot fetch (e.g. TTL refresh / pull-to-refresh). Use [forceServer] to bypass client cache.
  Future<ExchangeRateSnapshot?> fetchLatest({bool forceServer = true});
}

/// Placeholder that does not call Firebase — suitable until `firebase_options.dart` exists.
class MockRemoteRatesDataSource implements RemoteRatesDataSource {
  MockRemoteRatesDataSource();

  @override
  Stream<ExchangeRateSnapshot> watchRates() async* {
    yield ExchangeRateSnapshot.defaults();
    // Reserved: periodic refresh hook once Firestore is wired.
    await Future<void>.delayed(const Duration(days: 365));
  }

  @override
  Future<ExchangeRateSnapshot?> fetchLatest({bool forceServer = true}) async {
    return ExchangeRateSnapshot.defaults();
  }
}
