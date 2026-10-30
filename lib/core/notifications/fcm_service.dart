import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

const String kAllUsersFcmTopic = 'all_users';

/// Background isolate handler — must be a top-level function.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
    'FCM background: ${message.messageId} '
    'title=${message.notification?.title}',
  );
}

/// Request permission, register for APNs/FCM, subscribe to [kAllUsersFcmTopic].
class FcmService {
  FcmService._();

  static bool _initialized = false;
  static bool _subscribedAllUsers = false;

  static Future<void> initialize() async {
    if (kIsWeb || _initialized) return;
    _initialized = true;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    final messaging = FirebaseMessaging.instance;
    try {
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      debugPrint('FCM permission: ${settings.authorizationStatus}');
    } catch (e, st) {
      debugPrint('FCM requestPermission failed: $e\n$st');
    }

    // Show banners/sound while open; skip badge so it does not stick while active.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        'FCM foreground: ${message.notification?.title} — '
        '${message.notification?.body}',
      );
    });

    // Tapping a notification / cold-start from a push — mark as read (badge cleared natively).
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
        'FCM opened: ${message.notification?.title} — '
        '${message.notification?.body}',
      );
    });
    unawaited(() async {
      final initial = await messaging.getInitialMessage();
      if (initial != null) {
        debugPrint(
          'FCM initial: ${initial.notification?.title} — '
          '${initial.notification?.body}',
        );
      }
    }());

    messaging.onTokenRefresh.listen((token) {
      debugPrint('FCM token refresh: $token');
      unawaited(subscribeAllUsers(force: true));
    });

    try {
      final ready = await _ensureApplePushReady(messaging);
      if (!ready && (Platform.isIOS || Platform.isMacOS)) {
        debugPrint(
          'FCM: APNs token unavailable — Push capability / APNs key may be missing. '
          'Topic subscribe deferred.',
        );
        return;
      }
      final token = await messaging.getToken();
      debugPrint('FCM token: $token');
    } catch (e, st) {
      debugPrint('FCM getToken failed: $e\n$st');
    }
  }

  /// Subscribe this device to the broadcast topic (idempotent).
  static Future<void> subscribeAllUsers({bool force = false}) async {
    if (kIsWeb) return;
    if (_subscribedAllUsers && !force) return;

    final messaging = FirebaseMessaging.instance;
    try {
      final ready = await _ensureApplePushReady(messaging);
      if (!ready && (Platform.isIOS || Platform.isMacOS)) {
        debugPrint('FCM subscribe skipped: no APNs token yet');
        return;
      }
      await messaging.subscribeToTopic(kAllUsersFcmTopic);
      _subscribedAllUsers = true;
      debugPrint('FCM subscribed to $kAllUsersFcmTopic');
    } catch (e, st) {
      debugPrint('FCM subscribe failed: $e\n$st');
    }
  }

  static Future<void> unsubscribeAllUsers() async {
    if (kIsWeb) return;
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(kAllUsersFcmTopic);
      _subscribedAllUsers = false;
      debugPrint('FCM unsubscribed from $kAllUsersFcmTopic');
    } catch (e, st) {
      debugPrint('FCM unsubscribe failed: $e\n$st');
    }
  }

  /// iOS/macOS require an APNs device token before FCM token / topic APIs work.
  /// Kept short — called only from post-launch warmup, never on the splash path.
  static Future<bool> _ensureApplePushReady(FirebaseMessaging messaging) async {
    if (kIsWeb || !(Platform.isIOS || Platform.isMacOS)) return true;

    for (var attempt = 0; attempt < 4; attempt++) {
      final apns = await messaging.getAPNSToken();
      if (apns != null && apns.isNotEmpty) {
        debugPrint('FCM APNs token ready (attempt ${attempt + 1})');
        return true;
      }
      await Future<void>.delayed(Duration(milliseconds: 250 * (attempt + 1)));
    }
    return false;
  }
}
