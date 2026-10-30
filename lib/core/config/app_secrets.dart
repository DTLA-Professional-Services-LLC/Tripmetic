/// Build-time secrets and third-party credentials.
///
/// Every value is injected at compile time via `--dart-define` (or
/// `--dart-define-from-file`) so that no credential is ever committed to the
/// repository:
///
/// ```bash
/// flutter run \
///   --dart-define=MAPBOX_ACCESS_TOKEN=pk.xxxxx \
///   --dart-define=REVENUECAT_APPLE_KEY=appl.xxxxx \
///   --dart-define=REVENUECAT_GOOGLE_KEY=goog.xxxxx
/// ```
///
/// CI injects the same names from protected environment variables (see
/// `codemagic.yaml`). When a value is missing the placeholder default below
/// is used, so the app still compiles and boots — the affected feature
/// detects the placeholder with [AppSecrets.isConfigured] and degrades
/// gracefully instead of crashing.
abstract final class AppSecrets {
  /// Prefix used by every placeholder default in this file.
  ///
  /// [isConfigured] treats any value starting with it as "not configured".
  static const String placeholderPrefix = 'YOUR_';

  /// Mapbox **public** access token (`pk.…`) used by `MapboxOptions`.
  ///
  /// Public tokens are embedded in shipped binaries by design, but keeping
  /// them out of the repo means they can be rotated without a code change.
  static const String mapboxAccessToken = String.fromEnvironment(
    'MAPBOX_ACCESS_TOKEN',
    defaultValue: 'YOUR_MAPBOX_TOKEN',
  );

  /// RevenueCat **public** SDK key for the App Store (`appl.…`).
  static const String revenueCatAppleKey = String.fromEnvironment(
    'REVENUECAT_APPLE_KEY',
    defaultValue: 'YOUR_REVENUECAT_APPLE_KEY',
  );

  /// RevenueCat **public** SDK key for Google Play (`goog.…`).
  static const String revenueCatGoogleKey = String.fromEnvironment(
    'REVENUECAT_GOOGLE_KEY',
    defaultValue: 'YOUR_REVENUECAT_GOOGLE_KEY',
  );

  /// Whether [value] is a real credential rather than a placeholder.
  ///
  /// Callers use this to skip a feature (or show a "not configured" state)
  /// instead of calling a third-party SDK with a dummy token.
  static bool isConfigured(String value) {
    final String trimmed = value.trim();
    return trimmed.isNotEmpty && !trimmed.startsWith(placeholderPrefix);
  }
}
