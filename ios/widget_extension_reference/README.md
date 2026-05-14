# Dual Clock — iOS Lock Screen widget (reference)

These Swift files are **not** built by Flutter automatically. Add a **Widget Extension** target in Xcode and copy or merge the code from `DualClockWidget.swift`.

## Xcode setup

1. **App Group (Runner + widget extension)**  
   - Create/use identifier: `group.com.tripmetic.app`  
   - Enable **App Groups** on the main app target and on the widget extension.  
   - Match Flutter: `DualClockWidgetService.iosAppGroupId` uses this group.  
   - Optional style keys (written from Tripmetic → **Configure cities**): `dual_clock_font_scale`, `dual_clock_city_color`, `dual_clock_time_color`, `dual_clock_date_color` (`AARRGGBB` or `auto`), `dual_clock_use_text_shadow` (`1`/`0`).

2. **New target**  
   - File → New → Target → **Widget Extension**  
   - Deployment **iOS 16+** (for `.accessoryRectangular`).  
   - Replace the generated widget Swift file(s) with `DualClockWidget.swift` from this folder.

3. **Signing**  
   - Ensure the extension bundle ID is unique (e.g. `com.tripmetic.app.DualClockWidget`).  
   - Add the same App Group capability to the extension.

4. **Widget kind**  
   - The struct `DualClockWidget` uses `kind = "DualClockWidget"`. This **must** match `HomeWidget.updateWidget(iOSName: 'DualClockWidget')` in Flutter.

5. **Build settings (critical)**  
   - Do **not** set the extension target’s base configuration to Flutter’s `Debug.xcconfig` / `Release.xcconfig` (those can pull Flutter linker flags into the `.appex` and cause *Undefined symbol: \_Flutter…* link errors).  
   - In this repo, `DualClockWidgetExtension/Extension.xcconfig` includes only `Generated.xcconfig` for version macros and clears `OTHER_LDFLAGS` so the widget stays **pure SwiftUI + WidgetKit**.

6. **Run**  
   - Build the app, then on device: Lock Screen → Customize → Add Widgets → Tripmetic → Dual Clock.

If `containerBackground(for: .widget)` produces availability errors, wrap it with `#available(iOSApplicationExtension 17.0, *)` or remove and rely on the default accessory background.
