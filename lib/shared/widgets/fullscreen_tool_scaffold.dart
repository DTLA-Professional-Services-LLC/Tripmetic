import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'tripmetic_app_bar_title.dart';

/// Full-screen tool with back navigation (used from More hub).
class FullscreenToolScaffold extends StatelessWidget {
  const FullscreenToolScaffold({
    super.key,
    required this.subtitle,
    required this.child,
  });

  final String subtitle;
  final Widget child;

  Future<void> _onBackPressed(BuildContext context) async {
    if (context.canPop()) {
      context.pop();
      return;
    }
    // If this screen is the app's root (e.g. initialLocation), route to
    // the main shell so users are never trapped on a fullscreen tool.
    context.go('/currency');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _onBackPressed(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              _onBackPressed(context);
            },
          ),
          title: TripmeticAppBarTitle(subtitle: subtitle),
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
