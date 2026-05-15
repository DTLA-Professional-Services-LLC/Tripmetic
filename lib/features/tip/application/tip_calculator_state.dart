/// Cultural baseline for default tip % (user can override with slider).
///
/// [TipCountry.values] order is alphabetical by localized display name (dropdown).
/// Default selection is [TipCountry.usa].
enum TipCountry {
  brazil,
  china,
  colombia,
  dominicanRepublic,
  egypt,
  france,
  germany,
  hongKong,
  indonesia,
  italy,
  japan,
  mexico,
  morocco,
  portugal,
  singapore,
  spain,
  thailand,
  turkey,
  uae,
  unitedKingdom,
  usa,
}

extension TipCountryX on TipCountry {
  /// Default tip % for the country (slider / field allow 0–100).
  double get defaultTipPercent => switch (this) {
        TipCountry.brazil => 10,
        TipCountry.china => 0,
        TipCountry.colombia => 10,
        TipCountry.dominicanRepublic => 10,
        TipCountry.egypt => 12,
        TipCountry.france => 0,
        TipCountry.germany => 10,
        TipCountry.hongKong => 10,
        TipCountry.indonesia => 10,
        TipCountry.italy => 10,
        TipCountry.japan => 0,
        TipCountry.mexico => 15,
        TipCountry.morocco => 10,
        TipCountry.portugal => 10,
        TipCountry.singapore => 0,
        TipCountry.spain => 10,
        TipCountry.thailand => 10,
        TipCountry.turkey => 10,
        TipCountry.uae => 10,
        TipCountry.unitedKingdom => 12,
        TipCountry.usa => 20,
      };

  bool get hasZeroTipDefault => defaultTipPercent == 0;
}

class TipCalculatorState {
  const TipCalculatorState({
    required this.country,
    required this.billAmount,
    required this.tipPercent,
    required this.people,
  });

  final TipCountry country;
  final double billAmount;
  final double tipPercent;
  final int people;

  double get tipAmount => billAmount * (tipPercent / 100.0);

  double get totalWithTip => billAmount + tipAmount;

  double get amountPerPerson => people <= 0 ? totalWithTip : totalWithTip / people;

  TipCalculatorState copyWith({
    TipCountry? country,
    double? billAmount,
    double? tipPercent,
    int? people,
  }) {
    return TipCalculatorState(
      country: country ?? this.country,
      billAmount: billAmount ?? this.billAmount,
      tipPercent: tipPercent ?? this.tipPercent,
      people: people ?? this.people,
    );
  }

  static TipCalculatorState initial() {
    return TipCalculatorState(
      country: TipCountry.usa,
      billAmount: 0,
      tipPercent: TipCountry.usa.defaultTipPercent,
      people: 1,
    );
  }
}
