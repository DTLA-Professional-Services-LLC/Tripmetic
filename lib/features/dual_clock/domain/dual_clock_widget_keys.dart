/// Keys stored with [HomeWidget.saveWidgetData] — must match
/// [com.tripmetic.app.DualClockWidgetProvider] and the iOS widget UserDefaults keys.
abstract final class DualClockWidgetKeys {
  static const city1Name = 'dual_clock_city1_name';
  static const city1Tz = 'dual_clock_city1_tz';
  static const city2Name = 'dual_clock_city2_name';
  static const city2Tz = 'dual_clock_city2_tz';
  /// String like `1.05` — iOS lock-screen widget scales text (Android may ignore).
  static const fontScale = 'dual_clock_font_scale';
  /// `AARRGGBB` hex or `auto` for system primary/secondary.
  static const cityColorHex = 'dual_clock_city_color';
  static const timeColorHex = 'dual_clock_time_color';
  static const dateColorHex = 'dual_clock_date_color';
  /// `AARRGGBB` hex or `auto` for the default home-screen gradient / solid.
  static const backgroundColorHex = 'dual_clock_bg_color';
  /// `"1"` / `"0"` — subtle shadow behind text for photo wallpapers (iOS).
  static const useTextShadow = 'dual_clock_use_text_shadow';
}
