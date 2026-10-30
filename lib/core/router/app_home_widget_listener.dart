import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/widget_service.dart';

/// Routes home-screen widget taps into [GoRouter] while the app is running or cold-started.
class AppHomeWidgetListener extends StatefulWidget {
  const AppHomeWidgetListener({
    super.key,
    required this.router,
    required this.child,
  });

  final GoRouter router;
  final Widget child;

  @override
  State<AppHomeWidgetListener> createState() => _AppHomeWidgetListenerState();
}

class _AppHomeWidgetListenerState extends State<AppHomeWidgetListener> {
  StreamSubscription<Uri?>? _sub;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => _attach());
  }

  Future<void> _attach() async {
    if (!mounted) return;
    await WidgetService.handleInitialWidgetLaunch(widget.router);
    _sub = WidgetService.listenForWidgetClicks(widget.router);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
