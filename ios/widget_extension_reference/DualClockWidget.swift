import SwiftUI
import WidgetKit

// MARK: - Keys (must match Flutter `DualClockWidgetKeys` / Android provider)

private enum DualClockKeys {
    static let city1Name = "dual_clock_city1_name"
    static let city1Tz = "dual_clock_city1_tz"
    static let city2Name = "dual_clock_city2_name"
    static let city2Tz = "dual_clock_city2_tz"
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
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DualClockEntry>) -> Void) {
        let entry = loadEntry()
        let refresh = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date().addingTimeInterval(900)
        completion(Timeline(entries: [entry], policy: .after(refresh)))
    }

    private func loadEntry() -> DualClockEntry {
        let defaults = UserDefaults(suiteName: kAppGroupId)
        let c1 = defaults?.string(forKey: DualClockKeys.city1Name) ?? "Los Angeles"
        let z1 = defaults?.string(forKey: DualClockKeys.city1Tz) ?? "America/Los_Angeles"
        let c2 = defaults?.string(forKey: DualClockKeys.city2Name) ?? "New York"
        let z2 = defaults?.string(forKey: DualClockKeys.city2Tz) ?? "America/New_York"
        return DualClockEntry(date: Date(), city1: c1, tz1: z1, city2: c2, tz2: z2)
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
        if t.count <= 6 { return t }
        return String(t.prefix(6)) + "…"
    }
}

// MARK: - Rectangular (lock screen + larger accessory slots)

struct DualClockAccessoryRectangularView: View {
    var entry: DualClockEntry

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            locationColumn(city: entry.city1, tzId: entry.tz1)
            locationColumn(city: entry.city2, tzId: entry.tz2)
        }
        .widgetAccentable()
    }

    @ViewBuilder
    private func locationColumn(city: String, tzId: String) -> some View {
        let tz = TimeZone(identifier: tzId) ?? .current
        VStack(alignment: .leading, spacing: 2) {
            Text(city)
                .font(.caption2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            TimelineView(.periodic(from: .now, by: 60)) { timeline in
                Text(DualClockFormatters.formatTime(date: timeline.date, timeZone: tz))
                    .font(.caption)
                    .fontWeight(.medium)
                    .monospacedDigit()
                Text(DualClockFormatters.formatShortDate(date: timeline.date, timeZone: tz))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Inline (lock screen / Dynamic Island accessory line)

struct DualClockAccessoryInlineView: View {
    var entry: DualClockEntry

    var body: some View {
        TimelineView(.periodic(from: .now, by: 60)) { timeline in
            let tz1 = TimeZone(identifier: entry.tz1) ?? .current
            let tz2 = TimeZone(identifier: entry.tz2) ?? .current
            let t1 = DualClockFormatters.formatTime(date: timeline.date, timeZone: tz1)
            let t2 = DualClockFormatters.formatTime(date: timeline.date, timeZone: tz2)
            let c1 = DualClockFormatters.shortCityLabel(entry.city1)
            let c2 = DualClockFormatters.shortCityLabel(entry.city2)
            Text("\(c1) \(t1)  ·  \(c2) \(t2)")
                .font(.caption2)
                .fontWeight(.medium)
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.55)
        }
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
            DualClockWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    AccessoryWidgetBackground()
                }
        }
        .configurationDisplayName("Dual Clock")
        .description("Two cities with live time and date.")
        .supportedFamilies([.accessoryRectangular, .accessoryInline])
    }
}

/// Extension target entry point — only **one** `@main` in this widget extension.
@main
struct DualClockWidgetBundle: WidgetBundle {
    var body: some Widget {
        DualClockWidget()
    }
}
