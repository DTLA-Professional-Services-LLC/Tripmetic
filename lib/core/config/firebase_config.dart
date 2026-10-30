import 'package:firebase_core/firebase_core.dart';

import 'app_secrets.dart';

/// Firebase project options, driven entirely by `--dart-define`.
///
/// ```bash
/// flutter run \
///   --dart-define=FIREBASE_API_KEY=AIza… \
///   --dart-define=FIREBASE_APP_ID=1:1234567890:ios:abcdef \
///   --dart-define=FIREBASE_MESSAGING_SENDER_ID=1234567890 \
///   --dart-define=FIREBASE_PROJECT_ID=my-project
/// ```
///
/// When the defines are absent this returns `null` and Firebase falls back
/// to the platform configuration files (`google-services.json` on Android,
/// `GoogleService-Info.plist` on iOS). See `*.example` templates for those.
abstract final class FirebaseConfig {
  const FirebaseConfig._();

  static const String apiKey = String.fromEnvironment(
    'FIREBASE_API_KEY',
    defaultValue: 'YOUR_FIREBASE_API_KEY',
  );

  static const String appId = String.fromEnvironment(
    'FIREBASE_APP_ID',
    defaultValue: 'YOUR_FIREBASE_APP_ID',
  );

  static const String messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
    defaultValue: 'YOUR_FIREBASE_MESSAGING_SENDER_ID',
  );

  static const String projectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: 'YOUR_FIREBASE_PROJECT_ID',
  );

  static const String storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
    defaultValue: '',
  );

  static const String authDomain = String.fromEnvironment(
    'FIREBASE_AUTH_DOMAIN',
    defaultValue: '',
  );

  /// The Firebase options to use, or `null` when nothing was injected.
  ///
  /// `null` means "use the native platform config", which keeps local builds
  /// working with the checked-in `*.example` templates copied over the real
  /// file names.
  static FirebaseOptions? get options {
    final bool hasRequired =
        AppSecrets.isConfigured(apiKey) &&
        AppSecrets.isConfigured(appId) &&
        AppSecrets.isConfigured(messagingSenderId) &&
        AppSecrets.isConfigured(projectId);
    if (!hasRequired) return null;

    return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket.isEmpty ? null : storageBucket,
      authDomain: authDomain.isEmpty ? null : authDomain,
    );
  }

  /// Initializes the default Firebase app.
  ///
  /// Safe to call more than once — it is a no-op when Firebase is already up.
  static Future<void> initialize() async {
    if (Firebase.apps.isNotEmpty) return;
    await Firebase.initializeApp(options: options);
  }
}
