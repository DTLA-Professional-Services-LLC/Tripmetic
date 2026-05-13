import 'dart:io';

import 'package:home_widget/home_widget.dart';

import '../domain/dual_clock_widget_keys.dart';

/// Persists dual-city labels + IANA zones for Android/iOS home widgets.
class DualClockWidgetService {
  DualClockWidgetService._();

  /// Must match the App Group used by the iOS widget extension.
  static const iosAppGroupId = 'group.com.tripmetic.app';

  static Future<void> initIosAppGroup() async {
    if (Platform.isIOS) {
      await HomeWidget.setAppGroupId(iosAppGroupId);
    }
  }

  static Future<void> saveAndRefresh({
    required String city1Name,
    required String city1Tz,
    required String city2Name,
    required String city2Tz,
  }) async {
    await Future.wait<bool?>([
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city1Name, city1Name),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city1Tz, city1Tz),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city2Name, city2Name),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city2Tz, city2Tz),
    ]);
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.tripmetic.app.DualClockWidgetProvider',
      iOSName: 'DualClockWidget',
    );
  }
}
