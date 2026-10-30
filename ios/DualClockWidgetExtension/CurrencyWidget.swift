import SwiftUI
import WidgetKit

// MARK: - Keys (must match Flutter `CurrencyWidgetKeys`)

private enum CurrencyKeys {
    static let baseCode = "currency_widget_base_code"
    static let targetCode = "currency_widget_target_code"
    static let rateCaption = "currency_widget_rate_caption"
    static let ladder1 = "currency_widget_ladder_1"
    static let ladder20 = "currency_widget_ladder_20"
    static let ladder100 = "currency_widget_ladder_100"
    static let fontScale = "currency_widget_font_scale"
    static let primaryColorHex = "currency_widget_primary_color"
    static let secondaryColorHex = "currency_widget_secondary_color"
    static let captionColorHex = "currency_widget_caption_color"
    static let backgroundColorHex = "currency_widget_bg_color"
}

private let kCurrencyAppGroupId = "group.com.tripmetic.app"

// MARK: - Entry

struct CurrencyEntry: TimelineEntry {
    let date: Date
    let baseCode: String
    let targetCode: String
    let rateCaption: String
    let ladder1: String
    let ladder20: String
    let ladder100: String
}

// MARK: - Styles

private struct CurrencyHomeStyle {
    let fontScale: CGFloat
    let primary: Color
    let secondary: Color
    let caption: Color
    let background: Color?

    static func load(from defaults: UserDefaults?) -> CurrencyHomeStyle {
        let rawScale = Double(defaults?.string(forKey: CurrencyKeys.fontScale) ?? "1.0") ?? 1.0
        let fontScale = CGFloat(Swift.min(Swift.max(rawScale, 0.78), 2.0))
        let gold = Color(red: 0.83, green: 0.69, blue: 0.22)
        return CurrencyHomeStyle(
            fontScale: fontScale,
            primary: Color.currencyArgbHex(defaults?.string(forKey: CurrencyKeys.primaryColorHex)) ?? .white,
            secondary: Color.currencyArgbHex(defaults?.string(forKey: CurrencyKeys.secondaryColorHex)) ?? gold,
            caption: Color.currencyArgbHex(defaults?.string(forKey: CurrencyKeys.captionColorHex))
                ?? Color.white.opacity(0.45),
            background: Color.currencyArgbHex(defaults?.string(forKey: CurrencyKeys.backgroundColorHex))
        )
    }
}

private struct CurrencyAccessoryStyle {
    let fontScale: CGFloat
    let primary: Color?
    let secondary: Color?

    static func load(from defaults: UserDefaults?) -> CurrencyAccessoryStyle {
        let rawScale = Double(defaults?.string(forKey: CurrencyKeys.fontScale) ?? "1.0") ?? 1.0
        let fontScale = CGFloat(Swift.min(Swift.max(rawScale, 0.78), 2.0))
        return CurrencyAccessoryStyle(
            fontScale: fontScale,
            primary: Color.currencyArgbHex(defaults?.string(forKey: CurrencyKeys.primaryColorHex)),
            secondary: Color.currencyArgbHex(defaults?.string(forKey: CurrencyKeys.secondaryColorHex))
        )
    }
}

private extension Color {
    /// Accepts `RRGGBB`, `#RRGGBB`, `AARRGGBB`, or `#AARRGGBB`. Empty / `auto` → nil.
    static func currencyArgbHex(_ raw: String?) -> Color? {
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
            opacity: Double(a) / 255
        )
    }
}

private extension Comparable {
    func currencyClamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

// MARK: - Timeline

struct CurrencyProvider: TimelineProvider {
    typealias Entry = CurrencyEntry

    func placeholder(in context: Context) -> CurrencyEntry {
        CurrencyEntry(
            date: Date(),
            baseCode: "USD",
            targetCode: "EUR",
            rateCaption: "1 USD = 0.8591 EUR",
            ladder1: "0.86 EUR",
            ladder20: "17.18 EUR",
            ladder100: "85.91 EUR"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (CurrencyEntry) -> Void) {
        completion(makeEntry(at: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CurrencyEntry>) -> Void) {
        let now = Date()
        let entry = makeEntry(at: now)
        let next = Calendar.current.date(byAdding: .minute, value: 30, to: now) ?? now.addingTimeInterval(1800)
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func makeEntry(at date: Date) -> CurrencyEntry {
        let defaults = UserDefaults(suiteName: kCurrencyAppGroupId)
        let base = defaults?.string(forKey: CurrencyKeys.baseCode)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let target = defaults?.string(forKey: CurrencyKeys.targetCode)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let caption = defaults?.string(forKey: CurrencyKeys.rateCaption)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let l1 = defaults?.string(forKey: CurrencyKeys.ladder1)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let l20 = defaults?.string(forKey: CurrencyKeys.ladder20)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let l100 = defaults?.string(forKey: CurrencyKeys.ladder100)?.trimmingCharacters(in: .whitespacesAndNewlines)

        let baseCode = (base?.isEmpty == false) ? base! : "USD"
        let targetCode = (target?.isEmpty == false) ? target! : "EUR"

        return CurrencyEntry(
            date: date,
            baseCode: baseCode,
            targetCode: targetCode,
            rateCaption: (caption?.isEmpty == false) ? caption! : "Open Tripmetic to sync rates",
            ladder1: (l1?.isEmpty == false) ? l1! : "—",
            ladder20: (l20?.isEmpty == false) ? l20! : "—",
            ladder100: (l100?.isEmpty == false) ? l100! : "—"
        )
    }
}

// MARK: - Views

/// Home widgets have a fixed system frame — scale/compress content so all ladder
/// rows stay visible when the user picks a large font size.
private struct CurrencyHomeLayoutMetrics {
    let showBrand: Bool
    let showCaption: Bool
    let padding: CGFloat
    let spacing: CGFloat
    let brandPt: CGFloat
    let pairPt: CGFloat
    let arrowPt: CGFloat
    let captionPt: CGFloat
    let ladderLeftPt: CGFloat
    let ladderRightPt: CGFloat

    static func fit(height: CGFloat, requestedScale: CGFloat) -> CurrencyHomeLayoutMetrics {
        var s = requestedScale
        var showBrand = true
        var showCaption = true
        var padding: CGFloat = 12
        var spacing: CGFloat = 6

        func estimate() -> CGFloat {
            let brandH: CGFloat = showBrand ? (9 * s).currencyClamped(to: 8...14) : 0
            let pairH = (18 * s).currencyClamped(to: 14...26)
            let captionH: CGFloat = showCaption ? (10 * s).currencyClamped(to: 8...14) : 0
            let ladderH = (14 * s).currencyClamped(to: 11...18)
            let spacerCount = CGFloat((showBrand ? 1 : 0) + 1 + (showCaption ? 1 : 0) + 1 + 2)
            return (padding * 2) + brandH + pairH + captionH + 1 + (ladderH * 3) + (spacing * spacerCount)
        }

        for _ in 0..<40 {
            if estimate() <= height - 1 { break }
            if showBrand {
                showBrand = false
                continue
            }
            if showCaption && s > 1.15 {
                showCaption = false
                continue
            }
            if padding > 6 {
                padding -= 1
                continue
            }
            if spacing > 2 {
                spacing = max(2, spacing - 0.5)
                continue
            }
            s = max(0.78, s - 0.04)
        }

        let effectiveSpacing = max(2, min(spacing, 6 * s))
        return CurrencyHomeLayoutMetrics(
            showBrand: showBrand,
            showCaption: showCaption,
            padding: padding,
            spacing: effectiveSpacing,
            brandPt: (9 * s).currencyClamped(to: 8...14),
            pairPt: (18 * s).currencyClamped(to: 14...26),
            arrowPt: (14 * s).currencyClamped(to: 11...20),
            captionPt: (10 * s).currencyClamped(to: 8...14),
            ladderLeftPt: (13 * s).currencyClamped(to: 11...18),
            ladderRightPt: (14 * s).currencyClamped(to: 12...20)
        )
    }
}

private struct CurrencyHomeView: View {
    let entry: CurrencyEntry

    var body: some View {
        GeometryReader { geo in
            let style = CurrencyHomeStyle.load(from: UserDefaults(suiteName: kCurrencyAppGroupId))
            let m = CurrencyHomeLayoutMetrics.fit(height: geo.size.height, requestedScale: style.fontScale)

            VStack(alignment: .leading, spacing: m.spacing) {
                if m.showBrand {
                    Text("TRIPMETIC")
                        .font(.system(size: m.brandPt, weight: .bold))
                        .foregroundStyle(style.caption)
                        .lineLimit(1)
                }

                HStack(spacing: 6) {
                    Text(entry.baseCode)
                        .font(.system(size: m.pairPt, weight: .bold))
                        .foregroundStyle(style.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Text("→")
                        .font(.system(size: m.arrowPt, weight: .bold))
                        .foregroundStyle(style.secondary)
                    Text(entry.targetCode)
                        .font(.system(size: m.pairPt, weight: .bold))
                        .foregroundStyle(style.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Spacer(minLength: 0)
                }

                if m.showCaption {
                    Text(entry.rateCaption)
                        .font(.system(size: m.captionPt))
                        .foregroundStyle(style.caption)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }

                Divider().overlay(style.secondary.opacity(0.35))

                ladderRow(
                    base: "1 \(entry.baseCode)",
                    local: entry.ladder1,
                    style: style,
                    leftPt: m.ladderLeftPt,
                    rightPt: m.ladderRightPt
                )
                ladderRow(
                    base: "20 \(entry.baseCode)",
                    local: entry.ladder20,
                    style: style,
                    leftPt: m.ladderLeftPt,
                    rightPt: m.ladderRightPt
                )
                ladderRow(
                    base: "100 \(entry.baseCode)",
                    local: entry.ladder100,
                    style: style,
                    leftPt: m.ladderLeftPt,
                    rightPt: m.ladderRightPt
                )
            }
            .padding(m.padding)
            .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
        }
    }

    private func ladderRow(
        base: String,
        local: String,
        style: CurrencyHomeStyle,
        leftPt: CGFloat,
        rightPt: CGFloat
    ) -> some View {
        HStack {
            Text(base)
                .font(.system(size: leftPt, weight: .semibold))
                .foregroundStyle(style.secondary.opacity(0.8))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Spacer(minLength: 4)
            Text(local)
                .font(.system(size: rightPt, weight: .bold))
                .foregroundStyle(style.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.65)
        }
    }
}

private struct CurrencyAccessoryRectangularView: View {
    let entry: CurrencyEntry

    var body: some View {
        let style = CurrencyAccessoryStyle.load(from: UserDefaults(suiteName: kCurrencyAppGroupId))
        let s = style.fontScale
        VStack(alignment: .leading, spacing: 2) {
            Text("\(entry.baseCode) → \(entry.targetCode)")
                .font(.system(size: (13 * s).currencyClamped(to: 11...18), weight: .semibold))
                .foregroundStyle(style.primary ?? .primary)
            Text("1 → \(entry.ladder1)")
                .font(.system(size: (11 * s).currencyClamped(to: 9...15)))
                .foregroundStyle(style.secondary ?? .secondary)
            Text("100 → \(entry.ladder100)")
                .font(.system(size: (10 * s).currencyClamped(to: 8...14)))
                .foregroundStyle(style.secondary ?? .secondary)
        }
    }
}

private struct CurrencyAccessoryInlineView: View {
    let entry: CurrencyEntry

    var body: some View {
        let style = CurrencyAccessoryStyle.load(from: UserDefaults(suiteName: kCurrencyAppGroupId))
        let s = style.fontScale
        Text("\(entry.baseCode)→\(entry.targetCode) 1=\(entry.ladder1)")
            .font(.system(size: (12 * s).currencyClamped(to: 10...18), weight: .semibold))
    }
}

private struct CurrencyAccessoryCircularView: View {
    let entry: CurrencyEntry

    var body: some View {
        let style = CurrencyAccessoryStyle.load(from: UserDefaults(suiteName: kCurrencyAppGroupId))
        let s = style.fontScale
        let codePt = (10 * s).currencyClamped(to: 8...14)
        VStack(spacing: 1) {
            Text(entry.baseCode)
                .font(.system(size: codePt, weight: .bold))
                .foregroundStyle(style.primary ?? .primary)
            Text("→")
                .font(.system(size: (9 * s).currencyClamped(to: 7...12), weight: .semibold))
                .foregroundStyle(style.secondary ?? .secondary)
            Text(entry.targetCode)
                .font(.system(size: codePt, weight: .bold))
                .foregroundStyle(style.secondary ?? .primary)
        }
    }
}

struct CurrencyWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    let entry: CurrencyEntry

    var body: some View {
        switch family {
        case .accessoryInline:
            CurrencyAccessoryInlineView(entry: entry)
        case .accessoryCircular:
            CurrencyAccessoryCircularView(entry: entry)
        case .accessoryRectangular:
            CurrencyAccessoryRectangularView(entry: entry)
        default:
            CurrencyHomeView(entry: entry)
        }
    }
}

private func isCurrencyAccessoryFamily(_ family: WidgetFamily) -> Bool {
    switch family {
    case .accessoryInline, .accessoryRectangular, .accessoryCircular:
        return true
    default:
        return false
    }
}

private struct CurrencyHomeBackground: View {
    var body: some View {
        let style = CurrencyHomeStyle.load(from: UserDefaults(suiteName: kCurrencyAppGroupId))
        Group {
            if let bg = style.background {
                bg
            } else {
                LinearGradient(
                    colors: [
                        Color(red: 0.11, green: 0.15, blue: 0.25),
                        Color(red: 0.07, green: 0.09, blue: 0.16),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
    }
}

private struct CurrencyContainerBackgroundModifier: ViewModifier {
    @Environment(\.widgetFamily) private var family

    func body(content: Content) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            if isCurrencyAccessoryFamily(family) {
                content.containerBackground(for: .widget) {
                    AccessoryWidgetBackground()
                }
            } else {
                content.containerBackground(for: .widget) {
                    CurrencyHomeBackground()
                }
            }
        } else {
            content.background(CurrencyHomeBackground())
        }
    }
}

/// Widget kind must match `HomeWidget.updateWidget(iOSName:)` — `"CurrencyWidget"`.
struct CurrencyWidget: Widget {
    let kind: String = "CurrencyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CurrencyProvider()) { entry in
            CurrencyWidgetEntryView(entry: entry)
                .modifier(CurrencyContainerBackgroundModifier())
        }
        .configurationDisplayName("Currency converter")
        .description("Base and local currency with 1, 20, and 100 conversions.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryRectangular,
            .accessoryInline,
            .accessoryCircular,
        ])
    }
}
