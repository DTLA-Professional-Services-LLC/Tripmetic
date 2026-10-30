import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

String _detectPlatform() {
  if (kIsWeb) return 'web';
  if (Platform.isIOS) return 'ios';
  if (Platform.isAndroid) return 'android';
  if (Platform.isMacOS) return 'macos';
  if (Platform.isWindows) return 'windows';
  if (Platform.isLinux) return 'linux';
  return 'other';
}

String _platformVersion() {
  if (kIsWeb) return 'web';
  try {
    return Platform.operatingSystemVersion;
  } catch (_) {
    return '';
  }
}

/// Ensures `users/{uid}` exists with email / displayName / timestamps for admin
/// directory and lifetime-deal status attachment.
Future<void> ensureUserProfileDoc({
  User? user,
  String? displayNameOverride,
}) async {
  final u = user ?? FirebaseAuth.instance.currentUser;
  if (u == null) return;

  final ref = FirebaseFirestore.instance.collection('users').doc(u.uid);
  final platform = _detectPlatform();
  final platformVersion = _platformVersion();

  try {
    final existing = await ref.get();
    final name = (displayNameOverride?.trim().isNotEmpty ?? false)
        ? displayNameOverride!.trim()
        : (u.displayName?.trim().isNotEmpty ?? false)
            ? u.displayName!.trim()
            : (existing.data()?['displayName'] as String?)?.trim() ?? '';

    if (!existing.exists) {
      await ref.set({
        'email': u.email ?? '',
        'displayName': name,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'entitlement_status': 'none',
        'lifetime_access': false,
        'platform': platform,
        'platformVersion': platformVersion,
      });
      return;
    }

    await ref.set({
      'email': u.email ?? existing.data()?['email'] ?? '',
      'displayName': name.isNotEmpty
          ? name
          : (existing.data()?['displayName'] as String? ?? ''),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
      'platform': platform,
      'platformVersion': platformVersion,
    }, SetOptions(merge: true));
  } catch (e, st) {
    debugPrint('ensureUserProfileDoc failed: $e\n$st');
  }
}
