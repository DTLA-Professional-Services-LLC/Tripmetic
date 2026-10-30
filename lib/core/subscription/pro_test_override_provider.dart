import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences key holding the local "test as Pro" override.
const String kProTestOverrideKey = 'tripmetic_test_pro_override';

/// Per-device override that forces [isTripmeticProProvider] to report Pro,
/// regardless of RevenueCat state. Surfaced via the Settings screen so
/// internal testers can validate the Pro UX on a single phone even when
/// RevenueCat isn't configured (build 36 ships without it).
///
/// **Release builds:** disabled entirely (no UI, no persistence writes, no
/// effect on [isTripmeticProProvider]) so store builds cannot unlock Pro locally.
final proTestOverrideProvider =
    AsyncNotifierProvider<ProTestOverrideNotifier, bool>(
  ProTestOverrideNotifier.new,
);

class ProTestOverrideNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    if (kReleaseMode) {
      return false;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(kProTestOverrideKey) ?? false;
    } catch (e, st) {
      debugPrint('proTestOverrideProvider.build failed: $e\n$st');
      return false;
    }
  }

  /// Update the override and persist it to SharedPreferences.
  /// Listeners (e.g. [isTripmeticProProvider]) react synchronously so all
  /// gated screens refresh as soon as the toggle flips.
  Future<void> setOverride(bool value) async {
    if (kReleaseMode) {
      return;
    }
    state = AsyncData(value);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(kProTestOverrideKey, value);
    } catch (e, st) {
      debugPrint('proTestOverrideProvider.setOverride failed: $e\n$st');
    }
  }
}
