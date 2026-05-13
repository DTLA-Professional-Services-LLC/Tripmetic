import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/navigation/nav_feature_ids.dart';
import '../../core/navigation/tripmetic_home_navigation.dart';
import 'tripmetic_app_bar_title.dart';
import 'tripmetic_hub_app_bar_actions.dart';

/// Full-screen tool with back navigation (used from More hub).
///
/// IMPORTANT: this scaffold deliberately does NOT wrap the body with `ProGlassOverlay`.
/// The frosted Pro gate must live *inside* each feature's own Scaffold body so it cannot
/// destabilize the GoRouter shell / tab-switching tree (which previously triggered
/// `_dependents.isEmpty` assertions during route rebuilds).
class FullscreenToolScaffold extends ConsumerWidget {
  const FullscreenToolScaffold({
    super.key,
    required this.subtitle,
    required this.child,
    this.hubActions = false,
    @Deprecated(
      'ProGlassOverlay must be applied inside each feature, not at the router shell. '
      'This parameter is ignored and will be removed.',
    )
    this.proGateFeatureId,
  });

  final String subtitle;
  final Widget child;

  /// Kept for source compatibility while callsites migrate; no longer used.
  final String? proGateFeatureId;

  /// When true, shows the same account / theme / settings actions as [MainScreen].
  final bool hubActions;

  Future<void> _onBackPressed(BuildContext context, WidgetRef ref) async {
    if (context.canPop()) {
      context.pop();
      return;
    }
    goTripmeticHome(context, ref, selectFeatureId: NavFeatureIds.currency);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _onBackPressed(context, ref);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              _onBackPressed(context, ref);
            },
          ),
          title: TripmeticAppBarTitle(subtitle: subtitle),
          actions: hubActions ? tripmeticHubAppBarActions(context, ref) : null,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        ),
      ),
    );
  }
}
