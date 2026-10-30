/// Live or cached crypto prices: USD value of **1.0 unit** of each symbol.
class CryptoRatesSnapshot {
  const CryptoRatesSnapshot({
    required this.rates,
    required this.updatedAt,
    required this.isOffline,
  });

  final Map<String, double> rates;
  final DateTime updatedAt;
  final bool isOffline;
}
