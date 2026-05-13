import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shown when the announcements doc is missing, `html_content` is empty,
/// or the stream errors (e.g. offline with no cache).
const kFallbackAnnouncementsHtml =
    "<p>Welcome to <b>Tripmetic</b>! Ensure you are connected to the internet to see our latest travel tips and app updates.</p>";

String _parseAnnouncementsHtml(DocumentSnapshot snap) {
  if (!snap.exists) return kFallbackAnnouncementsHtml;
  final data = snap.data();
  if (data is! Map) return kFallbackAnnouncementsHtml;
  final raw = data['html_content'];
  if (raw is String && raw.trim().isNotEmpty) {
    return raw.trim();
  }
  return kFallbackAnnouncementsHtml;
}

/// Real-time HTML for Settings → Latest updates (`app_config/announcements`, field `html_content`).
final announcementsHtmlProvider = StreamProvider<String>((ref) {
  return FirebaseFirestore.instance
      .doc('app_config/announcements')
      .snapshots()
      .map(_parseAnnouncementsHtml);
});
