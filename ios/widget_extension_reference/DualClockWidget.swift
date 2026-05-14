import SwiftUI
import WidgetKit

// MARK: - Keys (must match Flutter `DualClockWidgetKeys` / Android provider)

private enum DualClockKeys {
    static let city1Name = "dual_clock_city1_name"
    static let city1Tz = "dual_clock_city1_tz"
    static let city2Name = "dual_clock_city2_name"
    static let city2Tz = "dual_clock_city2_tz"
    static let fontScale = "dual_clock_font_scale"
    static let cityColorHex = "dual_clock_city_color"
    static let timeColorHex = "dual_clock_time_color"
    static let dateColorHex = "dual_clock_date_color"
    static let useTextShadow = "dual_clock_use_text_shadow"
}

/// Must match `DualClockWidgetService.iosAppGroupId` in Flutter.
private let kAppGroupId = "group.com.tripmetic.app"

// MARK: - Entry

struct DualClockEntry: TimelineEntry {
    let date: Date
    let city1: String
    let tz1: String
    let city2: String
    let tz2: String
}

// MARK: - Style (App Group)

private struct DualClockStyle {
    let fontScale: CGFloat
    let cityColor: Color
    let timeColor: Color
    let dateColor: Color
    let useTextShadow: Bool

    static func load(from defaults: UserDefaults?) -> DualClockStyle {
        let rawScale = Double(defaults?.string(forKey: DualClockKeys.fontScale) ?? "1.0") ?? 1.0
        let fontScale = CGFloat(min(max(rawScale, 0.78), 1.55))

        let city = Color.argbHex(defaults?.string(forKey: DualClockKeys.cityColorHex)) ?? .primary
        let time = Color.argbHex(defaults?.string(forKey: DualClockKeys.timeColorHex)) ?? .primary
        let date = Color.argbHex(defaults?.string(forKey: DualClockKeys.dateColorHex)) ?? .secondary

        let shadowRaw = defaults?.string(forKey: DualClockKeys.useTextShadow) ?? "1"
        let useTextShadow = shadowRaw != "0" && shadowRaw.lowercased() != "false"

        return DualClockStyle(
            fontScale: fontScale,
            cityColor: city,
            timeColor: time,
            dateColor: date,
            useTextShadow: useTextShadow,
        )
    }
}

private extension Color {
    /// Accepts `RRGGBB`, `#RRGGBB`, `AARRGGBB`, or `#AARRGGBB`. Empty / invalid → nil (caller uses default).
    static func argbHex(_ raw: String?) -> Color? {
        guard var s = raw?.trimmingCharacters(in: .whitespacesAndNewlines), !s.isEmpty else { return nil }
        if s.lowercased() == "auto" { return nil }
        if s.hasPrefix("#") { s.removeFirst() }
        let scanner = Scanner(string: s)
        var hex: UInt64 = 0
        guard scanner.scanHexInt64(&hex) else { return nil }
        let a, r, g, b: UInt64
        switch s.count {
        case 6:
            (a, r, g, b) = (255, (hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF)
        case 8:
            (a, r, g, b) = ((hex >> 24) & 0xFF, (hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF)
        default:
            return nil
        }
        return Color(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255,
        )
    }
}

// MARK: - Timeline

struct DualClockProvider: TimelineProvider {
    typealias Entry = DualClockEntry

    func placeholder(in context: Context) -> DualClockEntry {
        DualClockEntry(
            date: Date(),
            city1: "Los Angeles",
            tz1: "America/Los_Angeles",
            city2: "New York",
            tz2: "America/New_York",
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (DualClockEntry) -> Void) {
        completion(makeEntry(at: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DualClockEntry>) -> Void) {
        let calendar = Calendar.current
        let now = Date()
        let startOfMinute = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)) ?? now

        /// One entry per minute so the system advances the clock without relying on
        /// `TimelineView(.periodic)` inside extensions (often frozen on the lock screen).
        let horizonMinutes = 240
        var entries: [DualClockEntry] = []
        entries.reserveCapacity(horizonMinutes)
        for i in 0..<horizonMinutes {
            if let d = calendar.date(byAdding: .minute, value: i, to: startOfMinute) {
                entries.append(makeEntry(at: d))
            }
        }

        let reload = calendar.date(byAdding: .minute, value: horizonMinutes + 1, to: startOfMinute)
            ?? now.addingTimeInterval(Double((horizonMinutes + 1) * 60))
        completion(Timeline(entries: entries, policy: .after(reload)))
    }

    private func makeEntry(at date: Date) -> DualClockEntry {
        let defaults = UserDefaults(suiteName: kAppGroupId)
        let c1 = defaults?.string(forKey: DualClockKeys.city1Name) ?? "Los Angeles"
        let z1 = defaults?.string(forKey: DualClockKeys.city1Tz) ?? "America/Los_Angeles"
        let c2 = defaults?.string(forKey: DualClockKeys.city2Name) ?? "New York"
        let z2 = defaults?.string(forKey: DualClockKeys.city2Tz) ?? "America/New_York"
        return DualClockEntry(date: date, city1: c1, tz1: z1, city2: c2, tz2: z2)
    }
}

// MARK: - Formatting

private enum DualClockFormatters {
    static func formatTime(date: Date, timeZone: TimeZone) -> String {
        let f = DateFormatter()
        f.timeZone = timeZone
        f.dateStyle = .none
        f.timeStyle = .short
        return f.string(from: date)
    }

    static func formatShortDate(date: Date, timeZone: TimeZone) -> String {
        let f = DateFormatter()
        f.timeZone = timeZone
        f.setLocalizedDateFormatFromTemplate("EEE MMM d")
        return f.string(from: date)
    }

    static func shortCityLabel(_ name: String) -> String {
        let t = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if t.isEmpty { return "—" }
        if t.count <= 8 { return t }
        return String(t.prefix(8)) + "…"
    }
}

// MARK: - Rectangular (lock screen + larger accessory slots)

struct DualClockAccessoryRectangularView: View {
    var entry: DualClockEntry

    var body: some View {
        let defaults = UserDefaults(suiteName: kAppGroupId)
        let style = DualClockStyle.load(from: defaults)
        let s = style.fontScale
        /// Base sizes tuned for accessoryRectangular; scale up for readability.
        let cityPt = (12 * s).clamped(to: 10...19)
        let timePt = (15 * s).clamped(to: 12...22)
        let datePt = (10 * s).clamped(to: 9...16)

        HStack(alignment: .top, spacing: 8 * s) {
            locationColumn(
                city: entry.city1,
                tzId: entry.tz1,
                at: entry.date,
                style: style,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
            )
            locationColumn(
                city: entry.city2,
                tzId: entry.tz2,
                at: entry.date,
                style: style,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
            )
        }
        .widgetAccentable()
    }

    @ViewBuilder
    private func locationColumn(
        city: String,
        tzId: String,
        at date: Date,
        style: DualClockStyle,
        cityPt: CGFloat,
        timePt: CGFloat,
        datePt: CGFloat,
    ) -> some View {
        let tz = TimeZone(identifier: tzId) ?? .current
        VStack(alignment: .leading, spacing: 3) {
            Text(city)
                .font(.system(size: cityPt, weight: .semibold, design: .rounded))
                .foregroundStyle(style.cityColor)
                .lineLimit(1)
                .minimumScaleFactor(0.82)
                .shadowIf(style.useTextShadow)
            Text(DualClockFormatters.formatTime(date: date, timeZone: tz))
                .font(.system(size: timePt, weight: .semibold, design: .rounded))
                .foregroundStyle(style.timeColor)
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .shadowIf(style.useTextShadow)
            Text(DualClockFormatters.formatShortDate(date: date, timeZone: tz))
                .font(.system(size: datePt, weight: .medium, design: .rounded))
                .foregroundStyle(style.dateColor)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .shadowIf(style.useTextShadow)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Inline (lock screen / Dynamic Island accessory line)

struct DualClockAccessoryInlineView: View {
    var entry: DualClockEntry

    var body: some View {
        let defaults = UserDefaults(suiteName: kAppGroupId)
        let style = DualClockStyle.load(from: defaults)
        let s = style.fontScale
        let linePt = (11 * s).clamped(to: 10...17)
        let tz1 = TimeZone(identifier: entry.tz1) ?? .current
        let tz2 = TimeZone(identifier: entry.tz2) ?? .current
        let t1 = DualClockFormatters.formatTime(date: entry.date, timeZone: tz1)
        let t2 = DualClockFormatters.formatTime(date: entry.date, timeZone: tz2)
        let c1 = DualClockFormatters.shortCityLabel(entry.city1)
        let c2 = DualClockFormatters.shortCityLabel(entry.city2)
        Text("\(c1) \(t1)  ·  \(c2) \(t2)")
            .font(.system(size: linePt, weight: .semibold, design: .rounded))
            .foregroundStyle(style.timeColor)
            .monospacedDigit()
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .shadowIf(style.useTextShadow)
    }
}

private extension View {
    @ViewBuilder
    func shadowIf(_ on: Bool) -> some View {
        if on {
            self.shadow(color: .black.opacity(0.62), radius: 1.2, x: 0, y: 1)
        } else {
            self
        }
    }
}

private extension CGFloat {
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

// MARK: - Router by widget family

struct DualClockWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    var entry: DualClockEntry

    var body: some View {
        switch family {
        case .accessoryInline:
            DualClockAccessoryInlineView(entry: entry)
        default:
            DualClockAccessoryRectangularView(entry: entry)
        }
    }
}

// MARK: - Widget

/// Widget kind must match `HomeWidget.updateWidget(iOSName:)` — `"DualClockWidget"`.
struct DualClockWidget: Widget {
    let kind: String = "DualClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DualClockProvider()) { entry in
            dualClockRoot(entry: entry)
        }
        .configurationDisplayName("Dual Clock")
        .description("Two cities with live time and date.")
        .supportedFamilies([.accessoryRectangular, .accessoryInline])
    }

    @ViewBuilder
    private func dualClockRoot(entry: DualClockEntry) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            DualClockWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    AccessoryWidgetBackground()
                }
        } else {
            DualClockWidgetEntryView(entry: entry)
        }
    }
}

/// Extension target entry point — only **one** `@main` in this widget extension.
@main
struct DualClockWidgetBundle: WidgetBundle {
    var body: some Widget {
        DualClockWidget()
    }
}
