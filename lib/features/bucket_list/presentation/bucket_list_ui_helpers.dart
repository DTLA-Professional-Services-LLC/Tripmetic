import 'package:intl/intl.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../domain/travel_destination.dart';

/// Compact trip range label, e.g. English `Oct 10 - Oct 24, 2026`.
String formatBucketListTripDateRange(
  DateTime start,
  DateTime end,
  String localeTag,
) {
  final s = DateTime(start.year, start.month, start.day);
  final e = DateTime(end.year, end.month, end.day);
  if (s.year == e.year && s.month == e.month) {
    final md = DateFormat.MMMd(localeTag);
    return '${md.format(s)} - ${md.format(e)}, ${s.year}';
  }
  if (s.year == e.year) {
    final md = DateFormat.MMMd(localeTag);
    return '${md.format(s)} - ${md.format(e)}, ${s.year}';
  }
  final full = DateFormat.yMMMd(localeTag);
  return '${full.format(s)} - ${full.format(e)}';
}

String categoryLabel(AppLocalizations l10n, TravelDestinationCategory c) {
  return switch (c) {
    TravelDestinationCategory.been => l10n.bucketListCategoryBeen,
    TravelDestinationCategory.want => l10n.bucketListCategoryWant,
    TravelDestinationCategory.live => l10n.bucketListCategoryLive,
    TravelDestinationCategory.lived => l10n.bucketListCategoryLived,
    TravelDestinationCategory.upcoming => l10n.bucketListCategoryUpcoming,
  };
}
