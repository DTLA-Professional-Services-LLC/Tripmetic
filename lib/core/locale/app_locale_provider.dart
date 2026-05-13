import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kLocaleOverride = 'app_locale_override_v1';

final appLocaleProvider = AsyncNotifierProvider<AppLocaleNotifier, Locale?>(
  AppLocaleNotifier.new,
);

class AppLocaleNotifier extends AsyncNotifier<Locale?> {
  @override
  Future<Locale?> build() async {
    final prefs = await SharedPreferences.getInstance();
    return _read(prefs);
  }

  Locale? _read(SharedPreferences prefs) {
    final code = prefs.getString(_kLocaleOverride);
    return switch (code) {
      'en' => const Locale('en'),
      'es' => const Locale('es'),
      _ => null,
    };
  }

  Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_kLocaleOverride);
      state = const AsyncData(null);
    } else {
      await prefs.setString(_kLocaleOverride, locale.languageCode);
      state = AsyncData(locale);
    }
  }
}
