/// Cultural baseline for default tip % (user can override with slider).
///
/// [TipCountry.values] order is alphabetical by [displayName] (dropdown list).
/// Default selection is [TipCountry.usa].
enum TipCountry {
  brazil,
  china,
  colombia,
  dominicanRepublic,
  egypt,
  mexico,
  spain,
  thailand,
  usa,
}

extension TipCountryX on TipCountry {
  String get displayName => switch (this) {
        TipCountry.brazil => 'Brazil',
        TipCountry.china => 'China',
        TipCountry.colombia => 'Colombia',
        TipCountry.dominicanRepublic => 'Dominican Republic',
        TipCountry.egypt => 'Egypt',
        TipCountry.mexico => 'Mexico',
        TipCountry.spain => 'Spain',
        TipCountry.thailand => 'Thailand',
        TipCountry.usa => 'United States',
      };

  /// Default tip % for the country (slider / field allow 0–100).
  double get defaultTipPercent => switch (this) {
        TipCountry.brazil => 10,
        TipCountry.china => 0,
        TipCountry.colombia => 10,
        TipCountry.dominicanRepublic => 10,
        TipCountry.egypt => 12,
        TipCountry.mexico => 15,
        TipCountry.spain => 10,
        TipCountry.thailand => 10,
        TipCountry.usa => 20,
      };
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
