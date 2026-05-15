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

// MARK: - Styles

/// Lock-screen accessories: system vibrancy only (no custom hex colors).
private struct DualClockAccessoryStyle {
    let fontScale: CGFloat

    static func load(from defaults: UserDefaults?) -> DualClockAccessoryStyle {
        let rawScale = Double(defaults?.string(forKey: DualClockKeys.fontScale) ?? "1.0") ?? 1.0
        let fontScale = CGFloat(Swift.min(Swift.max(rawScale, 0.78), 2.0))
        return DualClockAccessoryStyle(fontScale: fontScale)
    }
}

/// Home Screen widgets: custom colors + optional text shadow from App Group.
private struct DualClockHomeStyle {
    let fontScale: CGFloat
    let cityColor: Color
    let timeColor: Color
    let dateColor: Color
    let useTextShadow: Bool

    static func load(from defaults: UserDefaults?) -> DualClockHomeStyle {
        let rawScale = Double(defaults?.string(forKey: DualClockKeys.fontScale) ?? "1.0") ?? 1.0
        let fontScale = CGFloat(Swift.min(Swift.max(rawScale, 0.78), 2.0))

        let city = Color.argbHex(defaults?.string(forKey: DualClockKeys.cityColorHex)) ?? .white
        let time = Color.argbHex(defaults?.string(forKey: DualClockKeys.timeColorHex)) ?? .white
        let date = Color.argbHex(defaults?.string(forKey: DualClockKeys.dateColorHex))
            ?? Color.white.opacity(0.82)

        let shadowRaw = defaults?.string(forKey: DualClockKeys.useTextShadow) ?? "1"
        let useTextShadow = shadowRaw != "0" && shadowRaw.lowercased() != "false"

        return DualClockHomeStyle(
            fontScale: fontScale,
            cityColor: city,
            timeColor: time,
            dateColor: date,
            useTextShadow: useTextShadow,
        )
    }
}

private extension Color {
    /// Accepts `RRGGBB`, `#RRGGBB`, `AARRGGBB`, or `#AARRGGBB`. Empty / `auto` → nil.
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

    static func formatCompactDate(date: Date, timeZone: TimeZone) -> String {
        let f = DateFormatter()
        f.timeZone = timeZone
        f.setLocalizedDateFormatFromTemplate("MMM d")
        return f.string(from: date)
    }

    static func formatHomeDate(date: Date, timeZone: TimeZone) -> String {
        let f = DateFormatter()
        f.timeZone = timeZone
        f.setLocalizedDateFormatFromTemplate("EEE, MMM d")
        return f.string(from: date)
    }

    static func shortCityLabel(_ name: String) -> String {
        let t = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if t.isEmpty { return "—" }
        if t.count <= 8 { return t }
        return String(t.prefix(8)) + "…"
    }
}

// MARK: - Home Screen background

private struct DualClockHomeBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.06, green: 0.12, blue: 0.22),
                Color(red: 0.04, green: 0.08, blue: 0.16),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing,
        )
    }
}

// MARK: - Lock screen (accessory families)

struct DualClockAccessoryRectangularView: View {
    var entry: DualClockEntry

    var body: some View {
        let style = DualClockAccessoryStyle.load(from: UserDefaults(suiteName: kAppGroupId))
        let s = style.fontScale
        let cityPt = (16 * s).clamped(to: 12...36)
        let timePt = (20 * s).clamped(to: 16...42)
        let datePt = (13 * s).clamped(to: 11...28)

        HStack(alignment: .top, spacing: 0) {
            accessoryColumn(
                city: entry.city1,
                tzId: entry.tz1,
                at: entry.date,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
                columnAlignment: .leading,
            )
            Spacer(minLength: 8)
            accessoryColumn(
                city: entry.city2,
                tzId: entry.tz2,
                at: entry.date,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
                columnAlignment: .trailing,
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    @ViewBuilder
    private func accessoryColumn(
        city: String,
        tzId: String,
        at date: Date,
        cityPt: CGFloat,
        timePt: CGFloat,
        datePt: CGFloat,
        columnAlignment: HorizontalAlignment,
    ) -> some View {
        let tz = TimeZone(identifier: tzId) ?? .current
        let vAlignment: Alignment = columnAlignment == .leading ? .leading : .trailing
        let textAlign: TextAlignment = columnAlignment == .leading ? .leading : .trailing

        VStack(alignment: columnAlignment, spacing: 0) {
            Text(city)
                .font(.system(size: cityPt, weight: .semibold, design: .rounded))
                .lineLimit(2)
                .minimumScaleFactor(0.4)
                .multilineTextAlignment(textAlign)
            Spacer(minLength: 0)
            Text(DualClockFormatters.formatTime(date: date, timeZone: tz))
                .font(.system(size: timePt, weight: .semibold, design: .rounded))
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            Spacer(minLength: 0)
            Text(DualClockFormatters.formatCompactDate(date: date, timeZone: tz))
                .font(.system(size: datePt, weight: .medium, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.4)
        }
        .frame(maxHeight: .infinity, alignment: vAlignment)
    }
}

struct DualClockAccessoryInlineView: View {
    var entry: DualClockEntry

    var body: some View {
        let style = DualClockAccessoryStyle.load(from: UserDefaults(suiteName: kAppGroupId))
        let s = style.fontScale
        let linePt = (12 * s).clamped(to: 10...22)
        let tz1 = TimeZone(identifier: entry.tz1) ?? .current
        let tz2 = TimeZone(identifier: entry.tz2) ?? .current
        let t1 = DualClockFormatters.formatTime(date: entry.date, timeZone: tz1)
        let t2 = DualClockFormatters.formatTime(date: entry.date, timeZone: tz2)
        let c1 = DualClockFormatters.shortCityLabel(entry.city1)
        let c2 = DualClockFormatters.shortCityLabel(entry.city2)
        Text("\(c1) \(t1)  ·  \(c2) \(t2)")
            .font(.system(size: linePt, weight: .semibold, design: .rounded))
            .monospacedDigit()
            .lineLimit(1)
            .minimumScaleFactor(0.4)
    }
}

// MARK: - Home Screen (system families)

struct DualClockSystemMediumView: View {
    var entry: DualClockEntry

    var body: some View {
        let style = DualClockHomeStyle.load(from: UserDefaults(suiteName: kAppGroupId))
        let s = style.fontScale
        let cityPt = (15 * s).clamped(to: 12...22)
        let timePt = (24 * s).clamped(to: 18...34)
        let datePt = (12 * s).clamped(to: 10...18)

        HStack(alignment: .top, spacing: 12) {
            homeCityColumn(
                city: entry.city1,
                tzId: entry.tz1,
                at: entry.date,
                style: style,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
                alignment: .leading,
            )
            homeCityColumn(
                city: entry.city2,
                tzId: entry.tz2,
                at: entry.date,
                style: style,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
                alignment: .trailing,
            )
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct DualClockSystemSmallView: View {
    var entry: DualClockEntry

    var body: some View {
        let style = DualClockHomeStyle.load(from: UserDefaults(suiteName: kAppGroupId))
        let s = style.fontScale
        let cityPt = (12 * s).clamped(to: 10...17)
        let timePt = (18 * s).clamped(to: 14...26)
        let datePt = (10 * s).clamped(to: 9...14)

        VStack(alignment: .leading, spacing: 0) {
            homeCityColumn(
                city: entry.city1,
                tzId: entry.tz1,
                at: entry.date,
                style: style,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
                alignment: .leading,
            )
            Spacer(minLength: 4)
            Rectangle()
                .fill(Color.white.opacity(0.18))
                .frame(height: 1)
            Spacer(minLength: 4)
            homeCityColumn(
                city: entry.city2,
                tzId: entry.tz2,
                at: entry.date,
                style: style,
                cityPt: cityPt,
                timePt: timePt,
                datePt: datePt,
                alignment: .leading,
            )
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

@ViewBuilder
private func homeCityColumn(
    city: String,
    tzId: String,
    at date: Date,
    style: DualClockHomeStyle,
    cityPt: CGFloat,
    timePt: CGFloat,
    datePt: CGFloat,
    alignment: HorizontalAlignment,
) -> some View {
    let tz = TimeZone(identifier: tzId) ?? .current
    let hAlign: Alignment = alignment == .leading ? .leading : .trailing
    let textAlign: TextAlignment = alignment == .leading ? .leading : .trailing

    VStack(alignment: alignment, spacing: 3) {
        Text(city)
            .font(.system(size: cityPt, weight: .semibold, design: .rounded))
            .foregroundStyle(style.cityColor)
            .lineLimit(2)
            .minimumScaleFactor(0.4)
            .multilineTextAlignment(textAlign)
            .shadowIf(style.useTextShadow)
        Text(DualClockFormatters.formatTime(date: date, timeZone: tz))
            .font(.system(size: timePt, weight: .bold, design: .rounded))
            .foregroundStyle(style.timeColor)
            .monospacedDigit()
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .shadowIf(style.useTextShadow)
        Text(DualClockFormatters.formatHomeDate(date: date, timeZone: tz))
            .font(.system(size: datePt, weight: .medium, design: .rounded))
            .foregroundStyle(style.dateColor)
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .shadowIf(style.useTextShadow)
    }
    .frame(maxWidth: .infinity, alignment: hAlign)
}

// MARK: - Router by widget family

struct DualClockWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    var entry: DualClockEntry

    var body: some View {
        if isAccessoryFamily(family) {
            accessoryContent
        } else {
            homeScreenContent
        }
    }

    @ViewBuilder
    private var accessoryContent: some View {
        switch family {
        case .accessoryInline:
            DualClockAccessoryInlineView(entry: entry)
        default:
            DualClockAccessoryRectangularView(entry: entry)
        }
    }

    @ViewBuilder
    private var homeScreenContent: some View {
        switch family {
        case .systemMedium:
            DualClockSystemMediumView(entry: entry)
        case .systemSmall:
            DualClockSystemSmallView(entry: entry)
        default:
            DualClockSystemMediumView(entry: entry)
        }
    }
}

private func isAccessoryFamily(_ family: WidgetFamily) -> Bool {
    switch family {
    case .accessoryInline, .accessoryRectangular, .accessoryCircular:
        return true
    default:
        return false
    }
}

private extension View {
    @ViewBuilder
    func shadowIf(_ on: Bool) -> some View {
        if on {
            self.shadow(color: .black.opacity(0.45), radius: 1.5, x: 0, y: 1)
        } else {
            self
        }
    }
}

private extension CGFloat {
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
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
        .supportedFamilies([
            .accessoryRectangular,
            .accessoryInline,
            .systemSmall,
            .systemMedium,
        ])
    }

    @ViewBuilder
    private func dualClockRoot(entry: DualClockEntry) -> some View {
        DualClockWidgetEntryView(entry: entry)
            .modifier(DualClockContainerBackgroundModifier())
    }
}

/// Applies the correct WidgetKit container background per family (accessory vs home).
private struct DualClockContainerBackgroundModifier: ViewModifier {
    @Environment(\.widgetFamily) private var family

    func body(content: Content) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            if isAccessoryFamily(family) {
                content.containerBackground(for: .widget) {
                    AccessoryWidgetBackground()
                }
            } else {
                content.containerBackground(for: .widget) {
                    DualClockHomeBackground()
                }
            }
        } else {
            content
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
