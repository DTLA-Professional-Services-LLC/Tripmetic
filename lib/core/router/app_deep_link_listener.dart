import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/group_planner/data/group_trip_paths.dart';

/// Sends inbound Android/iOS links (`https://tripmetic.app/group-trip/...`, `tripmetic://…`) to GoRouter.
class AppDeepLinkListener extends StatefulWidget {
  const AppDeepLinkListener({
    super.key,
    required this.router,
    required this.child,
  });

  final GoRouter router;
  final Widget child;

  @override
  State<AppDeepLinkListener> createState() => _AppDeepLinkListenerState();
}

class _AppDeepLinkListenerState extends State<AppDeepLinkListener> {
  AppLinks? _appLinks;
  StreamSubscription<Uri>? _sub;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => _attach());
  }

  Future<void> _attach() async {
    if (kIsWeb) return;
    if (!mounted) return;
    final router = widget.router;
    _appLinks = AppLinks();
    final initial = await _appLinks!.getInitialLink();
    _goIfGroupTrip(initial, router);
    _sub = _appLinks!.uriLinkStream.listen(
      (uri) => _goIfGroupTrip(uri, router),
    );
  }

  void _goIfGroupTrip(Uri? uri, GoRouter router) {
    if (uri == null) return;
    String? raw;
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      if (uri.host != GroupTripPaths.deepLinkHttpsHost) return;
      raw = GroupTripPaths.extractTripRefFromUserInput(uri.toString());
    } else if (uri.scheme == 'tripmetic') {
      raw = GroupTripPaths.extractTripRefFromUserInput(uri.toString());
    }
    if (raw == null || raw.isEmpty) return;
    router.go('/group-trip/${Uri.encodeComponent(raw)}');
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
