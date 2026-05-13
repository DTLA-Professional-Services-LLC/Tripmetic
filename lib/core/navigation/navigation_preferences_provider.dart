import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nav_feature_ids.dart';

const String _kPinnedIds = 'nav_pinned_feature_ids_v1';

final navigationPreferencesProvider =
    AsyncNotifierProvider<NavigationPreferencesNotifier, List<String>>(
  NavigationPreferencesNotifier.new,
);

class NavigationPreferencesNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_kPinnedIds);
    return _sanitize(stored ?? NavFeatureIds.defaultPinned);
  }

  List<String> _sanitize(List<String> raw) {
    final valid = NavFeatureIds.pinnableIdSet;
    final out = <String>[];
    for (final id in raw) {
      if (valid.contains(id) && !out.contains(id)) {
        out.add(id);
      }
    }
    if (out.length > 4) {
      return out.take(4).toList(growable: false);
    }
    for (final d in NavFeatureIds.defaultPinned) {
      if (out.length >= 4) break;
      if (!out.contains(d)) out.add(d);
    }
    var i = 0;
    while (out.length < 4 && i < NavFeatureIds.pinnableIds.length) {
      final id = NavFeatureIds.pinnableIds[i++];
      if (!out.contains(id)) out.add(id);
    }
    return out.take(4).toList(growable: false);
  }

  Future<void> setPinned(List<String> ids) async {
    if (ids.length != 4 || ids.toSet().length != 4) return;
    final next = _sanitize(ids);
    if (next.length != 4) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kPinnedIds, next);
    state = AsyncData(next);
  }
}
