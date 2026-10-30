import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_brand.dart';
import 'core/locale/app_locale_provider.dart';
import 'core/router/app_deep_link_listener.dart';
import 'core/router/app_home_widget_listener.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_provider.dart';
import 'l10n/generated/app_localizations.dart';

class TripmeticApp extends ConsumerWidget {
  const TripmeticApp({super.key, this.applicationTitle = AppBrand.applicationTitle});

  /// Shown in the OS task switcher and as the default app label where Flutter exposes [MaterialApp.title].
  final String applicationTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.dark;
    final localeOverride = ref.watch(appLocaleProvider).maybeWhen(
          data: (v) => v,
          orElse: () => null,
        );
    return MaterialApp.router(
      title: applicationTitle,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      locale: localeOverride,
      theme: AppTheme.executiveLight(),
      darkTheme: AppTheme.executive(),
      routerConfig: router,
      builder: (context, child) => AppDeepLinkListener(
            router: router,
            child: AppHomeWidgetListener(
              router: router,
              child: child ?? const SizedBox.shrink(),
            ),
          ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supported) {
        if (locale == null) return supported.first;
        for (final l in supported) {
          if (l.languageCode == locale.languageCode) return l;
        }
        return supported.first;
      },
    );
  }
}
