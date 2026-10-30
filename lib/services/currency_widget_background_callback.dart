import 'package:flutter/foundation.dart';

import 'widget_service.dart';

/// Top-level entry point required by [HomeWidget.registerInteractivityCallback]
/// (static/class methods are not kept in release builds).
@pragma('vm:entry-point')
Future<void> currencyWidgetBackgroundCallback(Uri? uri) async {
  if (!_isRefreshUri(uri)) return;
  final ok = await WidgetService.refreshWidgetDirectly();
  debugPrint('currencyWidgetBackgroundCallback: refresh ${ok ? 'ok' : 'failed'}');
}

bool _isRefreshUri(Uri? uri) {
  if (uri == null) return false;
  if (uri.scheme != 'tripmetic' || uri.host != 'currency-widget') return false;
  final path = uri.path;
  return path == '/refresh' || path.endsWith('/refresh');
}
