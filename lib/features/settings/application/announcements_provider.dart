import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/locale/app_locale_provider.dart';
import '../../../core/locale/supported_app_locales.dart';

/// Shown when the announcements doc is missing, locale HTML is empty,
/// or the stream errors (e.g. offline with no cache).
const kFallbackAnnouncementsHtml =
    "<p>Welcome to <b>Tripmetic</b>! Ensure you are connected to the internet to see our latest travel tips and app updates.</p>";

/// Language codes that can have localized announcement HTML.
const List<String> kAnnouncementLocaleCodes = [
  'en',
  'es',
  'zh',
  'de',
  'fr',
  'ja',
  'pt',
  'ko',
  'hi',
  'ar',
];

String _resolveLanguageCode(Locale? override) {
  final code = override?.languageCode ??
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  if (supportedAppLocaleForCode(code) != null) return code;
  return 'en';
}

String _nonEmptyHtml(Object? raw) {
  if (raw is String && raw.trim().isNotEmpty) return raw.trim();
  return '';
}

/// Picks locale HTML from `html_by_locale`, then legacy `html_content`, then fallback.
String parseAnnouncementsHtml(DocumentSnapshot snap, String languageCode) {
  if (!snap.exists) return kFallbackAnnouncementsHtml;
  final data = snap.data();
  if (data is! Map) return kFallbackAnnouncementsHtml;

  final byLocale = data['html_by_locale'];
  if (byLocale is Map) {
    final localized = _nonEmptyHtml(byLocale[languageCode]);
    if (localized.isNotEmpty) return localized;
    final english = _nonEmptyHtml(byLocale['en']);
    if (english.isNotEmpty) return english;
  }

  final legacy = _nonEmptyHtml(data['html_content']);
  if (legacy.isNotEmpty) return legacy;
  return kFallbackAnnouncementsHtml;
}

/// Real-time HTML for Settings → Latest updates (`app_config/announcements`).
///
/// Prefers `html_by_locale[lang]`, then English locale / legacy `html_content`.
final announcementsHtmlProvider = StreamProvider<String>((ref) {
  final override = ref.watch(appLocaleProvider).valueOrNull;
  final languageCode = _resolveLanguageCode(override);

  return FirebaseFirestore.instance
      .doc('app_config/announcements')
      .snapshots()
      .map((snap) => parseAnnouncementsHtml(snap, languageCode));
});
