import '../../../l10n/generated/app_localizations.dart';

/// Apps from the p1.do portfolio ([https://p1.do/our-apps]).
///
/// Brand [name] stays fixed; tagline / summary / platforms come from [AppLocalizations].
class PortfolioApp {
  const PortfolioApp({
    required this.id,
    required this.name,
    required this.url,
    this.comingSoon = false,
    this.isCurrentApp = false,
  });

  final String id;

  /// Product / brand name (not localized).
  final String name;

  /// External product URL when live; ignored when [comingSoon] or [isCurrentApp].
  final String? url;
  final bool comingSoon;
  final bool isCurrentApp;

  String tagline(AppLocalizations l10n) => switch (id) {
        'travel_recap' => l10n.ourAppsTravelRecapTagline,
        'p1do' => l10n.ourAppsP1doTagline,
        'docktxt' => l10n.ourAppsDockTxtTagline,
        'tripmetic' => l10n.ourAppsTripmeticTagline,
        'payxt' => l10n.ourAppsPayxtTagline,
        'permitmobile' => l10n.ourAppsPermitMobileTagline,
        'trackkr' => l10n.ourAppsTrackkrTagline,
        'key_forecasts' => l10n.ourAppsKeyForecastsTagline,
        'stream_crm' => l10n.ourAppsStreamCrmTagline,
        _ => name,
      };

  String summary(AppLocalizations l10n) => switch (id) {
        'travel_recap' => l10n.ourAppsTravelRecapSummary,
        'p1do' => l10n.ourAppsP1doSummary,
        'docktxt' => l10n.ourAppsDockTxtSummary,
        'tripmetic' => l10n.ourAppsTripmeticSummary,
        'payxt' => l10n.ourAppsPayxtSummary,
        'permitmobile' => l10n.ourAppsPermitMobileSummary,
        'trackkr' => l10n.ourAppsTrackkrSummary,
        'key_forecasts' => l10n.ourAppsKeyForecastsSummary,
        'stream_crm' => l10n.ourAppsStreamCrmSummary,
        _ => '',
      };

  String platforms(AppLocalizations l10n) => switch (id) {
        'travel_recap' => l10n.ourAppsPlatformWeb,
        'p1do' => l10n.ourAppsPlatformWeb,
        'docktxt' => l10n.ourAppsPlatformMacos,
        'tripmetic' => l10n.ourAppsPlatformIosAndroid,
        'payxt' => l10n.ourAppsPlatformIosAndroidWeb,
        'permitmobile' => l10n.ourAppsPlatformWebMobile,
        'trackkr' => l10n.ourAppsPlatformWebTabletMobile,
        'key_forecasts' => l10n.ourAppsPlatformWeb,
        'stream_crm' => l10n.ourAppsPlatformWeb,
        _ => l10n.ourAppsPlatformWeb,
      };
}

/// Catalog mirrored from https://p1.do/our-apps (Stream CRM: coming soon).
const List<PortfolioApp> kPortfolioApps = [
  PortfolioApp(
    id: 'travel_recap',
    name: 'Travel Recap',
    url: 'https://travelrecap.app/',
  ),
  PortfolioApp(
    id: 'p1do',
    name: 'p1.do',
    url: 'https://p1.do/',
  ),
  PortfolioApp(
    id: 'docktxt',
    name: 'DockTxt',
    url: 'https://p1.do/docktxt',
  ),
  PortfolioApp(
    id: 'tripmetic',
    name: 'Tripmetic',
    url: null,
    isCurrentApp: true,
  ),
  PortfolioApp(
    id: 'payxt',
    name: 'PayXT',
    url: 'https://payxt.app/',
  ),
  PortfolioApp(
    id: 'permitmobile',
    name: 'PermitMobile',
    url: 'https://permitmobile.com/',
  ),
  PortfolioApp(
    id: 'trackkr',
    name: 'Trackkr',
    url: 'https://trackkr.app/',
  ),
  PortfolioApp(
    id: 'key_forecasts',
    name: 'Key Forecasts',
    url: 'https://keyforecasts.com/',
  ),
  PortfolioApp(
    id: 'stream_crm',
    name: 'Stream CRM',
    url: null,
    comingSoon: true,
  ),
];

const String kPortfolioAppsPageUrl = 'https://p1.do/our-apps';
