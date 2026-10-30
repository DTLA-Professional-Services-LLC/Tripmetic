import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kThemeModePrefsKey = 'app_theme_mode_v1';

/// Global app brightness (bound to [MaterialApp.themeMode]), persisted locally.
final themeModeProvider = AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return _decode(prefs.getString(kThemeModePrefsKey)) ?? ThemeMode.dark;
    } catch (e, st) {
      debugPrint('themeModeProvider.build failed: $e\n$st');
      return ThemeMode.dark;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = AsyncData(mode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(kThemeModePrefsKey, _encode(mode));
    } catch (e, st) {
      debugPrint('themeModeProvider.setTheme failed: $e\n$st');
    }
  }

  Future<void> toggle() async {
    final current = state.valueOrNull ?? ThemeMode.dark;
    await setTheme(current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  Future<void> setLight() => setTheme(ThemeMode.light);

  Future<void> setDark() => setTheme(ThemeMode.dark);

  static String _encode(ThemeMode mode) => switch (mode) {
        ThemeMode.system => 'system',
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
      };

  static ThemeMode? _decode(String? raw) => switch (raw) {
        'system' => ThemeMode.system,
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => null,
      };
}
