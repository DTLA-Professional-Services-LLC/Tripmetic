import 'package:flutter/material.dart';

/// Supported in-app locales (top travel-app markets).
///
/// [nativeLabel] is shown in the language picker — always in the language itself.
class SupportedAppLocale {
  const SupportedAppLocale({
    required this.locale,
    required this.nativeLabel,
  });

  final Locale locale;
  final String nativeLabel;
}

/// Ordered list for Settings → Language.
const List<SupportedAppLocale> kSupportedAppLocales = [
  SupportedAppLocale(locale: Locale('en'), nativeLabel: 'English'),
  SupportedAppLocale(locale: Locale('es'), nativeLabel: 'Español'),
  SupportedAppLocale(locale: Locale('zh'), nativeLabel: '简体中文'),
  SupportedAppLocale(locale: Locale('de'), nativeLabel: 'Deutsch'),
  SupportedAppLocale(locale: Locale('fr'), nativeLabel: 'Français'),
  SupportedAppLocale(locale: Locale('ja'), nativeLabel: '日本語'),
  SupportedAppLocale(locale: Locale('pt'), nativeLabel: 'Português'),
  SupportedAppLocale(locale: Locale('ko'), nativeLabel: '한국어'),
  SupportedAppLocale(locale: Locale('hi'), nativeLabel: 'हिन्दी'),
  SupportedAppLocale(locale: Locale('ar'), nativeLabel: 'العربية'),
];

SupportedAppLocale? supportedAppLocaleForCode(String? code) {
  if (code == null) return null;
  for (final entry in kSupportedAppLocales) {
    if (entry.locale.languageCode == code) return entry;
  }
  return null;
}
