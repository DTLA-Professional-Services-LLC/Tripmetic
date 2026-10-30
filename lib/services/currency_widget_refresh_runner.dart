import 'dart:io';

import 'package:flutter/foundation.dart';

import '../features/currency/data/currency_repository.dart';
import 'widget_service.dart';

/// Refreshes FX from the server and pushes the result to the Android widget.
///
/// Used from app bootstrap, widget deep links, and the home_widget background
/// callback (separate isolate — must not rely on [ProviderContainer]).
abstract final class CurrencyWidgetRefreshRunner {
  static Future<bool> refresh({CurrencyRepository? repo}) async {
    if (kIsWeb || !Platform.isAndroid) return false;

    if (repo != null) {
      try {
        await WidgetService.refreshAndSyncFromRepository(repo: repo);
        return repo.tryPersistedSnapshot() != null;
      } catch (e, st) {
        debugPrint('CurrencyWidgetRefreshRunner.refresh (repo) failed: $e\n$st');
        return false;
      }
    }

    return WidgetService.refreshWidgetDirectly();
  }

}
