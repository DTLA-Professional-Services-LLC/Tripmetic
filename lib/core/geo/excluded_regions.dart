/// Regions / currencies intentionally hidden from user-facing pickers and lists.
abstract final class ExcludedRegions {
  static const Set<String> countryNames = {'Israel'};
  static const Set<String> countryAlpha2 = {'IL'};
  static const Set<String> currencyCodes = {'ILS'};
  static const Set<String> cityLabels = {'Tel Aviv'};

  static bool isExcludedCountryName(String? name) {
    final n = name?.trim();
    if (n == null || n.isEmpty) return false;
    return countryNames.contains(n);
  }

  static bool isExcludedCountryAlpha2(String? code) {
    final c = code?.trim().toUpperCase();
    if (c == null || c.isEmpty) return false;
    return countryAlpha2.contains(c);
  }

  static bool isExcludedCurrencyCode(String? code) {
    final c = code?.trim().toUpperCase();
    if (c == null || c.isEmpty) return false;
    return currencyCodes.contains(c);
  }

  static bool isExcludedCityLabel(String? label) {
    final l = label?.trim();
    if (l == null || l.isEmpty) return false;
    return cityLabels.contains(l);
  }
}
