/// Firestore layout for group collaboration.
abstract final class GroupTripPaths {
  static const String collection = 'group_trips';

  static const String membersSubcollection = 'members';

  static const String activitiesSubcollection = 'activities';

  /// Maps short invite codes (document id) → real `group_trips` document id.
  static const String inviteCodesCollection = 'trip_invite_codes';

  /// HTTPS host used in share links and [httpsDeepLink]. Must match Android intent-filters.
  static const String deepLinkHttpsHost = 'tripmetic.app';

  /// App Store listing (invite fallback when the app is not installed).
  static const String iosAppStoreUrl =
      'https://apps.apple.com/us/app/tripmetic/id6765632920';

  /// Google Play listing (invite fallback when the app is not installed).
  static const String androidPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=com.tripmetic.app';

  static const String androidAppPackage = 'com.tripmetic.app';

  /// Custom scheme base (see Android manifest `tripmetic` + host `group-trip`).
  static String customSchemeDeepLink(String inviteOrTripId) =>
      'tripmetic://group-trip/$inviteOrTripId';

  /// Universal link / app link form (requires hosted assetlinks + router handling).
  static String httpsDeepLink(String inviteOrTripId) =>
      'https://$deepLinkHttpsHost/group-trip/$inviteOrTripId';

  /// Android Chrome intent: opens the app if installed, otherwise [androidPlayStoreUrl].
  ///
  /// See https://developer.chrome.com/docs/android/intents/
  static String androidInviteIntentUrl(String inviteOrTripId) {
    final pathTail = Uri.encodeComponent(inviteOrTripId);
    final fallback = Uri.encodeComponent(androidPlayStoreUrl);
    return 'intent://group-trip/$pathTail#Intent;scheme=tripmetic;package=$androidAppPackage;S.browser_fallback_url=$fallback;end';
  }

  /// Extracts trip code or UUID from pasted text (full URL, `tripmetic://`, or raw code).
  static String extractTripRefFromUserInput(String raw) {
    final s = raw.trim();
    if (s.isEmpty) return s;

    final asUri = Uri.tryParse(s);
    if (asUri != null &&
        asUri.hasScheme &&
        (asUri.scheme == 'http' ||
            asUri.scheme == 'https' ||
            asUri.scheme == 'tripmetic')) {
      final fromHttps = _segmentAfter(asUri.pathSegments, 'group-trip');
      if (fromHttps != null && fromHttps.isNotEmpty) {
        return Uri.decodeComponent(fromHttps);
      }
      if (asUri.scheme == 'tripmetic' &&
          asUri.host == 'group-trip' &&
          asUri.path.isNotEmpty) {
        final p = asUri.path;
        final tail = p.startsWith('/') ? p.substring(1) : p;
        if (tail.isNotEmpty) return Uri.decodeComponent(tail);
      }
    }
    return s;
  }

  static String? _segmentAfter(List<String> segments, String marker) {
    final i = segments.indexOf(marker);
    if (i < 0 || i + 1 >= segments.length) return null;
    return segments[i + 1];
  }
}

