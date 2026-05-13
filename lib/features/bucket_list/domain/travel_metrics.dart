import 'bucket_list_geo.dart';
import 'travel_destination.dart';

class TravelExplorationMetrics {
  TravelExplorationMetrics({
    required this.worldExploredPercent,
    required this.usExploredPercent,
    required this.usTerritoriesExploredPercent,
    required this.europeExploredPercent,
    required this.asiaExploredPercent,
    required this.africaExploredPercent,
    required this.uniqueCountriesVisited,
    required this.uniqueUsStatesVisited,
    required this.uniqueUsTerritoriesVisited,
    required this.uniqueEuropeanCountriesVisited,
    required this.uniqueAsianCountriesVisited,
    required this.uniqueAfricanCountriesVisited,
  });

  final double worldExploredPercent;
  final double usExploredPercent;
  final double usTerritoriesExploredPercent;
  final double europeExploredPercent;
  final double asiaExploredPercent;
  final double africaExploredPercent;
  final int uniqueCountriesVisited;
  final int uniqueUsStatesVisited;
  final int uniqueUsTerritoriesVisited;
  final int uniqueEuropeanCountriesVisited;
  final int uniqueAsianCountriesVisited;
  final int uniqueAfricanCountriesVisited;

  static const int kWorldCountryDenominator = 195;
  static const int kUsStateDenominator = 50;
  static const int kUsTerritoryDenominator = 5;
  static const int kEuropeCountryDenominator = 44;
  static const int kAsiaCountryDenominator = 48;
  static const int kAfricaCountryDenominator = 54;

  /// True when the user has physically been in the place: visited, lives there,
  /// or lived there. Used for world/country stats and map share (not want/upcoming).
  static bool countsTowardExploration(TravelDestination d) {
    return switch (d.category) {
      TravelDestinationCategory.been ||
      TravelDestinationCategory.live ||
      TravelDestinationCategory.lived =>
        true,
      TravelDestinationCategory.want ||
      TravelDestinationCategory.upcoming =>
        false,
    };
  }

  static TravelExplorationMetrics fromDestinations(
    List<TravelDestination> all,
  ) {
    final explored = all.where(countsTowardExploration);

    final countries = <String>{};
    final usStates = <String>{};
    final usTerritories = <String>{};
    final europeCountries = <String>{};
    final asianCountries = <String>{};
    final africanCountries = <String>{};

    for (final d in explored) {
      final raw = d.country.trim();
      if (raw.isEmpty) continue;

      if (isUnitedStatesTerritoryCountry(raw)) {
        usTerritories.add(raw);
      } else {
        countries.add(raw);
      }

      if (isUnitedStatesCountry(d.country)) {
        final stateKey = _inferUsState(d);
        if (stateKey != null) {
          usStates.add(stateKey);
        }
      }

      if (isEuropeanCountry(d.country)) {
        europeCountries.add(d.country);
      }

      if (isAsianCountry(d.country)) {
        asianCountries.add(d.country);
      }

      if (isAfricanCountry(d.country)) {
        africanCountries.add(d.country);
      }
    }

    double pct(int num, int den) =>
        den <= 0 ? 0 : (num / den * 100).clamp(0, 100).toDouble();

    return TravelExplorationMetrics(
      worldExploredPercent: pct(countries.length, kWorldCountryDenominator),
      usExploredPercent: pct(usStates.length, kUsStateDenominator),
      usTerritoriesExploredPercent:
          pct(usTerritories.length, kUsTerritoryDenominator),
      europeExploredPercent:
          pct(europeCountries.length, kEuropeCountryDenominator),
      asiaExploredPercent: pct(asianCountries.length, kAsiaCountryDenominator),
      africaExploredPercent:
          pct(africanCountries.length, kAfricaCountryDenominator),
      uniqueCountriesVisited: countries.length,
      uniqueUsStatesVisited: usStates.length,
      uniqueUsTerritoriesVisited: usTerritories.length,
      uniqueEuropeanCountriesVisited: europeCountries.length,
      uniqueAsianCountriesVisited: asianCountries.length,
      uniqueAfricanCountriesVisited: africanCountries.length,
    );
  }

  static String? _inferUsState(TravelDestination d) {
    final fromState = d.state?.trim();
    if (fromState != null && fromState.isNotEmpty) {
      final key = resolveUsStateKey(fromState);
      if (key != null) return key;
    }
    return null;
  }
}
