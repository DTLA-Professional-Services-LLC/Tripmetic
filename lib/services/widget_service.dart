import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_widget/home_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/data/sync/composite_fiat_rates_data_source.dart';
import '../features/currency/application/currency_providers.dart';
import '../features/currency/application/exchange_calculator.dart';
import '../features/currency/data/currency_repository.dart';
import '../features/currency/domain/exchange_rate_snapshot.dart';
import 'currency_widget_refresh_runner.dart';

/// SharedPreferences / App Group keys — must match Android + iOS Currency widgets.
abstract final class CurrencyWidgetKeys {
  static const baseCode = 'currency_widget_base_code';
  static const targetCode = 'currency_widget_target_code';
  static const baseAmount = 'currency_widget_base_amount';
  static const targetAmount = 'currency_widget_target_amount';
  static const exchangeRate = 'currency_widget_exchange_rate';
  static const rateCaption = 'currency_widget_rate_caption';
  /// Formatted local amounts for 1 / 20 / 100 units of the base currency.
  static const ladder1 = 'currency_widget_ladder_1';
  static const ladder20 = 'currency_widget_ladder_20';
  static const ladder100 = 'currency_widget_ladder_100';

  /// Appearance (iOS home / lock; Android best-effort).
  static const fontScale = 'currency_widget_font_scale';
  static const primaryColorHex = 'currency_widget_primary_color';
  static const secondaryColorHex = 'currency_widget_secondary_color';
  static const captionColorHex = 'currency_widget_caption_color';
  static const backgroundColorHex = 'currency_widget_bg_color';
}

/// Fixed base amounts shown on the home / lock-screen currency widget.
const List<double> kCurrencyWidgetLadderAmounts = [1, 20, 100];

/// URIs emitted when the user taps areas on the Android home-screen widget.
abstract final class CurrencyWidgetUris {
  static final select = Uri.parse('tripmetic://currency-widget/select');
  static final refresh = Uri.parse('tripmetic://currency-widget/refresh');
}

/// Persists currency converter state for the Android home-screen widget.
class WidgetService {
  WidgetService._();

  static const _androidProvider = 'com.tripmetic.app.CurrencyWidgetProvider';
  static const _iosWidgetName = 'CurrencyWidget';

  /// Invoked when the user taps Refresh on the home-screen widget (Android background).
  static Future<void> Function()? currencyWidgetRefreshHandler;

  /// Must match the App Group used by the iOS widget extension.
  static const iosAppGroupId = 'group.com.tripmetic.app';

  static bool get _supportsNativeCurrencyWidget =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static String? _lastSyncedTargetRateKey;

  static void resetWidgetSyncCache() => _lastSyncedTargetRateKey = null;

  static ExchangeRateSnapshot _cachedSnapshotForWidget(CurrencyRepository? repo) {
    return repo?.tryPersistedSnapshot() ?? ExchangeRateSnapshot.defaults();
  }

  static Future<ExchangeRateSnapshot> _fetchSnapshotForWidget(CurrencyRepository? repo) async {
    if (repo != null) {
      try {
        final fresh = await repo.refreshFromNetwork();
        if (fresh != null) return fresh;
      } catch (e, st) {
        debugPrint('WidgetService: repo refresh failed: $e\n$st');
      }
      return _cachedSnapshotForWidget(repo);
    }

    try {
      final snap = await CompositeFiatRatesDataSource().fetchLatest(forceServer: true);
      if (snap != null) return snap;
    } catch (e, st) {
      debugPrint('WidgetService: composite fetch failed: $e\n$st');
    }
    return ExchangeRateSnapshot.defaults();
  }

  /// Pushes base → first currency ladder with the best available live rates.
  static Future<void> seedAndroidCurrencyWidget({CurrencyRepository? repo}) async {
    if (!_supportsNativeCurrencyWidget) return;

    resetWidgetSyncCache();
    final snapshot = await _fetchSnapshotForWidget(repo);
    final codes = repo?.readSelection() ?? kDefaultCurrencySelection;
    final ctx = await _widgetCurrencyContext(repo);
    final base = ctx.base.isNotEmpty ? ctx.base : codes[0];
    final target = ctx.target.isNotEmpty ? ctx.target : codes[1];

    await syncFromSnapshot(
      snapshot: snapshot,
      baseCode: base,
      targetCode: target,
      syncedAt: DateTime.now(),
    );
  }

  static Future<void> initIosAppGroup() async {
    if (Platform.isIOS) {
      await HomeWidget.setAppGroupId(iosAppGroupId);
    }
  }

  /// Saves formatted widget payload (pair + 1/20/100 ladder) and refreshes natives.
  static Future<void> saveCurrencyWidgetAndRefresh({
    required String baseCode,
    required String targetCode,
    required double exchangeRate,
    required String ladder1,
    required String ladder20,
    required String ladder100,
    ExchangeRateSnapshot? snapshot,
    DateTime? syncedAt,
  }) async {
    final baseFiat = fiatCurrencyOrUsd(baseCode);
    final targetFiat = fiatCurrencyOrUsd(targetCode);
    final rateText = _rateCaption(
      baseCode: baseFiat.code,
      targetCode: targetFiat.code,
      rate: exchangeRate,
      snapshot: snapshot,
      syncedAt: syncedAt,
    );

    await Future.wait<bool?>([
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.baseCode, baseFiat.code),
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.targetCode, targetFiat.code),
      // Legacy single-amount keys (1 unit) for older widget installs.
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.baseAmount, '1'),
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.targetAmount, ladder1),
      HomeWidget.saveWidgetData<String>(
        CurrencyWidgetKeys.exchangeRate,
        exchangeRate.toStringAsFixed(6),
      ),
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.rateCaption, rateText),
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.ladder1, ladder1),
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.ladder20, ladder20),
      HomeWidget.saveWidgetData<String>(CurrencyWidgetKeys.ladder100, ladder100),
    ]);

    await _updateNativeWidgets();
  }

  static Future<void> _updateNativeWidgets() async {
    if (Platform.isAndroid) {
      await HomeWidget.updateWidget(qualifiedAndroidName: _androidProvider);
    }
    if (Platform.isIOS) {
      await HomeWidget.updateWidget(iOSName: _iosWidgetName);
    }
  }

  /// Convenience wrapper when you already have an [ExchangeRateSnapshot].
  /// Always writes conversions for 1, 20, and 100 units of [baseCode].
  static Future<void> syncFromSnapshot({
    required ExchangeRateSnapshot snapshot,
    required String baseCode,
    required String targetCode,
    @Deprecated('Ladder always uses 1/20/100') double baseAmountValue = 1,
    DateTime? syncedAt,
  }) async {
    if (!_supportsNativeCurrencyWidget) return;

    final normalizedBase = fiatCurrencyOrUsd(baseCode).code;
    final normalizedTarget = fiatCurrencyOrUsd(targetCode).code;
    final targetFiat = fiatCurrencyOrUsd(normalizedTarget);
    final rate = snapshot.rateFor(normalizedTarget) / snapshot.rateFor(normalizedBase);

    String ladderLabel(double baseAmount) {
      final usd = usdFromAmount(snapshot, normalizedBase, baseAmount);
      final local = amountFromUsd(snapshot, normalizedTarget, usd);
      return '${formatForCurrency(local, targetFiat)} ${targetFiat.code}';
    }

    final ladder1 = ladderLabel(1);
    final ladder20 = ladderLabel(20);
    final ladder100 = ladderLabel(100);

    final stampMs = (syncedAt ?? snapshot.updatedAt).millisecondsSinceEpoch;
    final syncKey =
        '$normalizedBase|$normalizedTarget|${rate.toStringAsFixed(6)}|'
        '$ladder1|$ladder20|$ladder100|$stampMs';
    if (_lastSyncedTargetRateKey == syncKey) return;
    _lastSyncedTargetRateKey = syncKey;

    await saveCurrencyWidgetAndRefresh(
      baseCode: normalizedBase,
      targetCode: normalizedTarget,
      exchangeRate: rate,
      ladder1: ladder1,
      ladder20: ladder20,
      ladder100: ladder100,
      snapshot: snapshot,
      syncedAt: syncedAt,
    );
  }

  /// Currency pair currently stored on the home-screen widget.
  static Future<({String base, String target, double baseAmount})> readWidgetCurrencyPair({
    CurrencyRepository? repo,
  }) {
    return _widgetCurrencyContext(repo);
  }

  /// Pushes explicit base/target codes to the widget (after in-app picker).
  static Future<void> syncWidgetPair({
    required ExchangeRateSnapshot snapshot,
    required String baseCode,
    required String targetCode,
    double? baseAmountValue,
    DateTime? syncedAt,
  }) async {
    if (!_supportsNativeCurrencyWidget) return;

    resetWidgetSyncCache();
    await syncFromSnapshot(
      snapshot: snapshot,
      baseCode: baseCode,
      targetCode: targetCode,
      syncedAt: syncedAt ?? DateTime.now(),
    );
  }

  /// Reads the currency pair shown on the widget (falls back to saved app prefs).
  static Future<({String base, String target, double baseAmount})> _widgetCurrencyContext(
    CurrencyRepository? repo,
  ) async {
    final codes = repo?.readSelection() ?? kDefaultCurrencySelection;
    final baseFromWidget = (await HomeWidget.getWidgetData<String>(CurrencyWidgetKeys.baseCode))?.trim();
    final targetFromWidget =
        (await HomeWidget.getWidgetData<String>(CurrencyWidgetKeys.targetCode))?.trim();
    final baseCode =
        (baseFromWidget != null && baseFromWidget.isNotEmpty) ? baseFromWidget : codes[0];
    final targetCode =
        (targetFromWidget != null && targetFromWidget.isNotEmpty) ? targetFromWidget : codes[1];

    final baseAmountRaw =
        (await HomeWidget.getWidgetData<String>(CurrencyWidgetKeys.baseAmount))?.trim();
    var baseAmount = 1.0;
    if (baseAmountRaw != null && baseAmountRaw.isNotEmpty) {
      final parsed = parseAmountInput(baseAmountRaw.replaceAll(RegExp(r'[^0-9.,]'), ''));
      if (parsed != null && parsed > 0) {
        baseAmount = parsed;
      }
    }

    return (base: baseCode, target: targetCode, baseAmount: baseAmount);
  }

  /// Fetches Firestore FX and writes straight to the widget (no Hive / no app UI).
  static Future<bool> refreshWidgetDirectly() async {
    if (!_supportsNativeCurrencyWidget) return false;

    resetWidgetSyncCache();
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      final snap = await CompositeFiatRatesDataSource().fetchLatest(forceServer: true) ??
          ExchangeRateSnapshot.defaults();

      if (snap.serverRateOverlays.isNotEmpty) {
        await _bestEffortPersistToHive(snap);
      }

      final ctx = await _widgetCurrencyContext(null);
      await syncFromSnapshot(
        snapshot: snap,
        baseCode: ctx.base,
        targetCode: ctx.target,
        syncedAt: DateTime.now(),
      );
      return true;
    } catch (e, st) {
      debugPrint('WidgetService.refreshWidgetDirectly failed: $e\n$st');
      return false;
    }
  }

  static Future<void> _bestEffortPersistToHive(ExchangeRateSnapshot snap) async {
    try {
      await Hive.initFlutter();
      final box = await Hive.openBox<dynamic>('tripmetic_cache');
      final overlays = snap.serverRateOverlays;
      if (overlays.isNotEmpty) {
        await box.put('exchange_rates_v2', overlays);
        final updatedMs = snap.updatedAt.millisecondsSinceEpoch;
        if (updatedMs > 0) {
          await box.put('exchange_rates_updated_ms', updatedMs);
        }
      }
      await box.close();
    } catch (e) {
      debugPrint('WidgetService: skipped Hive persist during widget refresh: $e');
    }
  }

  /// Syncs slot 0 → base and slot 1 → target from in-app currency state.
  /// Pushes the in-app selection (slot 0 = base, slot 1 = target) to the widget.
  /// Unlike [syncFromRepository], this does not prefer previously stored widget keys.
  static Future<void> syncFromCurrencyState({
    required ExchangeRateSnapshot snapshot,
    required List<String> codes,
    required double usdAmount,
  }) async {
    if (!_supportsNativeCurrencyWidget || codes.length < 2) return;

    resetWidgetSyncCache();
    await syncFromSnapshot(
      snapshot: snapshot,
      baseCode: codes[0],
      targetCode: codes[1],
    );
  }

  /// Pushes Hive-backed FX + saved prefs to the home-screen widget.
  static Future<void> syncFromRepository(
    CurrencyRepository repo, {
    DateTime? syncedAt,
  }) async {
    if (!_supportsNativeCurrencyWidget) return;

    final snapshot = _cachedSnapshotForWidget(repo);
    final ctx = await _widgetCurrencyContext(repo);
    await syncFromSnapshot(
      snapshot: snapshot,
      baseCode: ctx.base,
      targetCode: ctx.target,
      syncedAt: syncedAt,
    );
  }

  /// Server fetch, then push the latest persisted rates to the widget.
  static Future<void> refreshAndSyncFromRepository({
    required CurrencyRepository repo,
  }) async {
    if (!_supportsNativeCurrencyWidget) return;

    _lastSyncedTargetRateKey = null;
    try {
      await repo.refreshFromNetwork();
    } catch (e, st) {
      debugPrint('WidgetService: refreshFromNetwork failed: $e\n$st');
    }
    await syncFromRepository(repo, syncedAt: DateTime.now());
  }

  /// Handles widget refresh taps (foreground or after cold start).
  static Future<bool> performCurrencyWidgetRefresh({CurrencyRepository? repo}) {
    return CurrencyWidgetRefreshRunner.refresh(repo: repo);
  }

  /// Keeps the currency widget in sync whenever live rates change.
  static void startAutoSync(ProviderContainer container) {
    if (!_supportsNativeCurrencyWidget) return;

    container.listen<AsyncValue<ExchangeRateSnapshot>>(
      exchangeRatesStreamProvider,
      (previous, next) {
        next.whenData((snap) {
          if (snap.isOffline) return;
          unawaited(syncFromRepository(container.read(currencyRepositoryProvider)));
        });
      },
    );
  }

  /// Persist appearance prefs and refresh native currency widgets.
  static Future<void> saveCurrencyWidgetStyleAndRefresh({
    double fontScale = 1.0,
    String primaryColorHex = 'auto',
    String secondaryColorHex = 'auto',
    String captionColorHex = 'auto',
    String backgroundColorHex = 'auto',
  }) async {
    if (!_supportsNativeCurrencyWidget) return;

    final fs = fontScale.clamp(0.78, 2.0);
    await Future.wait<bool?>([
      HomeWidget.saveWidgetData<String>(
        CurrencyWidgetKeys.fontScale,
        fs.toStringAsFixed(2),
      ),
      HomeWidget.saveWidgetData<String>(
        CurrencyWidgetKeys.primaryColorHex,
        primaryColorHex,
      ),
      HomeWidget.saveWidgetData<String>(
        CurrencyWidgetKeys.secondaryColorHex,
        secondaryColorHex,
      ),
      HomeWidget.saveWidgetData<String>(
        CurrencyWidgetKeys.captionColorHex,
        captionColorHex,
      ),
      HomeWidget.saveWidgetData<String>(
        CurrencyWidgetKeys.backgroundColorHex,
        backgroundColorHex,
      ),
    ]);
    await _updateNativeWidgets();
  }

  /// Bootstrap helper: push cached rates immediately, refresh network in background.
  static Future<void> bootstrapAndroidWidget(ProviderContainer container) async {
    if (!_supportsNativeCurrencyWidget) return;

    final repo = container.read(currencyRepositoryProvider);
    _lastSyncedTargetRateKey = null;
    await syncFromRepository(repo, syncedAt: DateTime.now());
    startAutoSync(container);
    try {
      await repo.refreshFromNetwork();
      await syncFromRepository(repo, syncedAt: DateTime.now());
    } catch (e, st) {
      debugPrint('WidgetService: FX refresh failed during bootstrap: $e\n$st');
    }
  }

  static String _rateCaption({
    required String baseCode,
    required String targetCode,
    required double rate,
    ExchangeRateSnapshot? snapshot,
    DateTime? syncedAt,
  }) {
    final rateLabel = rate >= 1
        ? '1 $baseCode = ${rate.toStringAsFixed(4)} $targetCode'
        : '1 $targetCode = ${(1 / rate).toStringAsFixed(4)} $baseCode';
    final stampSource = syncedAt ?? snapshot?.updatedAt;
    if (stampSource == null) return rateLabel;
    final updated = stampSource.toLocal();
    if (updated.millisecondsSinceEpoch <= 0) return rateLabel;
    final hh = updated.hour.toString().padLeft(2, '0');
    final mm = updated.minute.toString().padLeft(2, '0');
    return '$rateLabel · $hh:$mm';
  }

  /// Maps widget / deep-link URIs to in-app GoRouter paths.
  static String? routePathForExternalUri(Uri uri) {
    if (uri.scheme != 'tripmetic') return null;

    if (uri.host == 'currency-widget') {
      final path = uri.path;
      if (path == '/select' || path.endsWith('/select')) {
        final slot = uri.queryParameters['slot'];
        if (slot != null && slot.isNotEmpty) {
          return '/currency-widget/select?slot=$slot';
        }
        return '/currency-widget/select?slot=1';
      }
      if (path == '/refresh' || path.endsWith('/refresh')) {
        return '/currency-widget/refresh';
      }
    }

    return null;
  }

  /// Routes widget taps to in-app screens. Call from app start and from
  /// [HomeWidget.widgetClicked].
  static Future<void> routeFromWidgetUri(Uri? uri, GoRouter router) async {
    if (uri == null) return;

    final route = routePathForExternalUri(uri);
    if (route == null) return;

    if (route == '/currency-widget/refresh') {
      final handler = currencyWidgetRefreshHandler;
      if (handler != null) {
        await handler();
      } else {
        await performCurrencyWidgetRefresh();
      }
      if (router.canPop()) {
        router.pop();
      } else {
        router.go('/');
      }
      return;
    }

    router.go(route);
  }

  /// Listens for widget launches while the app is running.
  static StreamSubscription<Uri?> listenForWidgetClicks(GoRouter router) {
    return HomeWidget.widgetClicked.listen((uri) {
      unawaited(routeFromWidgetUri(uri, router));
    });
  }

  /// Checks whether the app cold-started from a widget tap.
  static Future<void> handleInitialWidgetLaunch(GoRouter router) async {
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    await routeFromWidgetUri(uri, router);
  }

  /// Register once during bootstrap for widget background interactions.
  static Future<void> registerInteractivityCallback(
    Future<void> Function(Uri?) callback,
  ) {
    return HomeWidget.registerInteractivityCallback(callback);
  }
}
