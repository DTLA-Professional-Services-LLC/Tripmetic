import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'main_nav_intent_provider.dart';
import 'navigation_preferences_provider.dart';

void goTripmeticHome(
  BuildContext context,
  WidgetRef ref, {
  String? selectFeatureId,
}) {
  if (selectFeatureId != null) {
    final pins = ref.read(navigationPreferencesProvider).value;
    if (pins != null && pins.length >= 4) {
      final idx = pins.indexOf(selectFeatureId);
      ref.read(currentTabIndexProvider.notifier).state =
          (idx >= 0 && idx < 4) ? idx : 4;
    }
  }
  context.go('/');
}
