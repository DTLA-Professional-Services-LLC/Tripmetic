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
    double fontScale = 1.0,
    String cityColorHex = 'auto',
    String timeColorHex = 'auto',
    String dateColorHex = 'auto',
    bool useTextShadow = true,
  }) async {
    final fs = fontScale.clamp(0.78, 2.0);
    await Future.wait<bool?>([
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city1Name, city1Name),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city1Tz, city1Tz),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city2Name, city2Name),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.city2Tz, city2Tz),
      HomeWidget.saveWidgetData<String>(
        DualClockWidgetKeys.fontScale,
        fs.toStringAsFixed(2),
      ),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.cityColorHex, cityColorHex),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.timeColorHex, timeColorHex),
      HomeWidget.saveWidgetData<String>(DualClockWidgetKeys.dateColorHex, dateColorHex),
      HomeWidget.saveWidgetData<String>(
        DualClockWidgetKeys.useTextShadow,
        useTextShadow ? '1' : '0',
      ),
    ]);
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.tripmetic.app.DualClockWidgetProvider',
      iOSName: 'DualClockWidget',
    );
  }
}
