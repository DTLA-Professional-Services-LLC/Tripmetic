import 'package:flutter/material.dart';

import 'travel_destination.dart';

/// Canonical colors for bucket-list categories (map markers, choropleth, list icons).
abstract final class BucketListCategoryColors {
  BucketListCategoryColors._();

  /// Green #4CAF50
  static const int beenArgb = 0xFF4CAF50;

  /// Yellow #FFEB3B
  static const int wantArgb = 0xFFFFEB3B;

  /// Blue #2196F3
  static const int liveArgb = 0xFF2196F3;

  /// Purple #9C27B0
  static const int livedArgb = 0xFF9C27B0;

  /// Orange #FF9800
  static const int upcomingArgb = 0xFFFF9800;

  static int categoryArgb(TravelDestinationCategory c) => switch (c) {
        TravelDestinationCategory.been => beenArgb,
        TravelDestinationCategory.want => wantArgb,
        TravelDestinationCategory.live => liveArgb,
        TravelDestinationCategory.lived => livedArgb,
        TravelDestinationCategory.upcoming => upcomingArgb,
      };

  static Color categoryColor(TravelDestinationCategory c) =>
      Color(categoryArgb(c));

  /// Map-marker colors tuned for legibility on light cards (e.g. Popular tab toggles).
  static Color readableOnSurface(
    TravelDestinationCategory c,
    Brightness brightness,
  ) {
    if (brightness == Brightness.dark) return categoryColor(c);
    return switch (c) {
      TravelDestinationCategory.been => const Color(0xFF2E7D32),
      TravelDestinationCategory.want => const Color(0xFFB8860B),
      TravelDestinationCategory.live => const Color(0xFF1565C0),
      TravelDestinationCategory.lived => const Color(0xFF6A1B9A),
      TravelDestinationCategory.upcoming => const Color(0xFFE65100),
    };
  }

  /// Mapbox style-spec `rgba(...)` for choropleth fills from category ARGB.
  static String categoryFillRgba(TravelDestinationCategory c,
          {double alpha = 0.45}) =>
      categoryArgbToFillRgba(categoryArgb(c), alpha: alpha);

  /// Converts 0xAARRGGBB to `rgba(r,g,b,a)` for Mapbox paint expressions.
  static String categoryArgbToFillRgba(int argb, {double alpha = 0.45}) {
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;
    return 'rgba($r, $g, $b, $alpha)';
  }

  /// Mapbox `fill-color` for “been” country choropleth (#4CAF50 with alpha).
  static String beenChoroplethFillRgba({double alpha = 0.45}) =>
      categoryFillRgba(TravelDestinationCategory.been, alpha: alpha);
}
