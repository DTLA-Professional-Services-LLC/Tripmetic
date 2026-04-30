import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_brand.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';

class TripmeticApp extends ConsumerWidget {
  const TripmeticApp({super.key, this.applicationTitle = AppBrand.applicationTitle});

  /// Shown in the OS task switcher and as the default app label where Flutter exposes [MaterialApp.title].
  final String applicationTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: applicationTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.executive(),
      routerConfig: router,
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
