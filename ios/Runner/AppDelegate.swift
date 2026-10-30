import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  // Firebase is configured from Dart (firebase_core / app_bootstrap). Do not
  // call FirebaseApp.configure() here — duplicate init can misconfigure or crash.

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Required for APNs → FCM token / topic subscribe (Push entitlement must include aps-environment).
    application.registerForRemoteNotifications()
    // Clear any leftover broadcast badge from a previous session.
    Self.clearAppIconBadge()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  /// Broadcast pushes set `aps.badge`; clear when the user opens/returns to the app.
  override func applicationDidBecomeActive(_ application: UIApplication) {
    super.applicationDidBecomeActive(application)
    Self.clearAppIconBadge()
  }

  private static func clearAppIconBadge() {
    UIApplication.shared.applicationIconBadgeNumber = 0
    if #available(iOS 16.0, *) {
      UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: { _ in })
    }
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
