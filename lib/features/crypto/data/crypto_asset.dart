/// One cryptocurrency (or USD) with an offline mock USD price per 1.0 unit.
class CryptoAsset {
  const CryptoAsset(this.id, this.name, this.usdPerUnit);

  final String id;
  final String name;

  /// Mock: US dollar value of 1.0 unit of this asset (USD is always 1).
  final double usdPerUnit;
}
