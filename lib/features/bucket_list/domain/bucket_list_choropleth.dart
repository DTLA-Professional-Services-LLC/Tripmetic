import 'bucket_list_category_colors.dart';
import 'bucket_list_mapbox_country_names.dart';
import 'travel_destination.dart';

/// Priority when multiple highlighted categories exist for one country.
const int _kPriorityBeen = 1;
const int _kPriorityLive = 2;
const int _kPriorityLived = 3;

/// Choropleth matches Mapbox `name_en` to [TravelDestination.country] only
/// (city/state are ignored so e.g. the whole United States polygon fills once).
String _choroplethCountryKey(TravelDestination d) => d.country.trim();

/// Fill-color expression for Mapbox `country_boundaries` layer:
/// [`match`, [`get`, `name_en`, …], …, transparent].
///
/// Only [TravelDestinationCategory.been], [.live], and [.lived] contribute.
/// [TravelDestinationCategory.want] and [.upcoming] are list-only (not on map).
/// Fallback is fully transparent so the basemap remains visible.
///
/// Colors use [BucketListCategoryColors] (`been` green, `live` blue, `lived` purple).
List<Object> buildBucketListCountryFillColorExpression(
  List<TravelDestination> destinations,
) {
  /// Solid RGBA values; opacity is applied via the FillLayer’s `fillOpacity`.
  final beenColor =
      BucketListCategoryColors.categoryFillRgba(TravelDestinationCategory.been,
          alpha: 1);
  final liveColor =
      BucketListCategoryColors.categoryFillRgba(TravelDestinationCategory.live,
          alpha: 1);
  final livedColor =
      BucketListCategoryColors.categoryFillRgba(TravelDestinationCategory.lived,
          alpha: 1);
  const transparent = 'rgba(0, 0, 0, 0)';

  final best = <String, int>{};
  for (final d in destinations) {
    final p = switch (d.category) {
      TravelDestinationCategory.been => _kPriorityBeen,
      TravelDestinationCategory.live => _kPriorityLive,
      TravelDestinationCategory.lived => _kPriorityLived,
      _ => 0,
    };
    if (p == 0) continue;
    final country = _choroplethCountryKey(d);
    if (country.isEmpty) continue;
    final prev = best[country] ?? 0;
    if (p > prev) best[country] = p;
  }

  final expr = <Object>[
    'match',
    <Object>['get', 'name_en'],
  ];

  for (final e in best.entries) {
    final labels = mapAppCountryToMapboxNameEnSynonyms(e.key);
    final color = switch (e.value) {
      _kPriorityLived => livedColor,
      _kPriorityLive => liveColor,
      _kPriorityBeen => beenColor,
      int() => transparent,
    };
    for (final label in labels) {
      if (label.isEmpty) continue;
      expr.add(label);
      expr.add(color);
    }
  }

  expr.add(transparent);
  return expr;
}
