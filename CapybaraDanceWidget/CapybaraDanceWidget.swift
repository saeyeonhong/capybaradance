//
//  CapybaraDanceWidget.swift
//  CapybaraDanceWidget
//
//  Created by Saeyeon Hong on 2/20/26.
//

import WidgetKit
import SwiftUI

// MARK: - Animation Frames

private let capybaraFrames: [String] = [
    // Frame 0: Neutral stance
    "   ___\n  /o o\\\n (  -  )\n (     )\n   | |\n  /   \\",
    // Frame 1: Arms raised
    " \\  ___  /\n   /o o\\\n  (  -  )\n  (     )\n    | |\n    | |",
    // Frame 2: Lean left
    "  ___\n /o o\\\n(  -  )\n(     )\n  | |\n /   ",
    // Frame 3: Lean right
    "     ___\n    /o o\\\n   (  -  )\n   (     )\n     | |\n        \\",
    // Frame 4: Happy face
    "   ___\n  /^ ^\\\n (  w  )\n (     )\n   | |\n  /   \\",
]

// MARK: - Timeline Entry

struct SimpleEntry: TimelineEntry {
    let date: Date
    let frameIndex: Int

    var frame: String { capybaraFrames[frameIndex] }
}

// MARK: - Provider

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), frameIndex: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(), frameIndex: 0))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        let startDate = Date()
        let frameInterval: TimeInterval = 1.0
        // 5 minutes of animation, then auto-reload
        let count = 300

        for i in 0..<count {
            let entryDate = startDate.addingTimeInterval(Double(i) * frameInterval)
            entries.append(SimpleEntry(date: entryDate, frameIndex: i % capybaraFrames.count))
        }

        let reloadDate = startDate.addingTimeInterval(Double(count) * frameInterval)
        completion(Timeline(entries: entries, policy: .after(reloadDate)))
    }
}

// MARK: - Widget View

struct CapybaraDanceWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var fontSize: CGFloat {
        family == .systemSmall ? 9 : 13
    }

    var body: some View {
        ZStack {
            Color.black

            VStack(spacing: 4) {
                Text("Capybara")
                    .font(.caption2.bold())
                    .foregroundStyle(.yellow)

                Text(entry.frame)
                    .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                    .foregroundStyle(.green)
                    .multilineTextAlignment(.center)

                if family != .systemSmall {
                    Text("is dancing! 🎵")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                }
            }
            .padding(6)
        }
    }
}

// MARK: - Widget

struct CapybaraDanceWidget: Widget {
    let kind: String = "CapybaraDanceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CapybaraDanceWidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("Capybara Dance")
        .description("Watch a capybara groove on your home screen!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview

#Preview(as: .systemSmall) {
    CapybaraDanceWidget()
} timeline: {
    SimpleEntry(date: .now, frameIndex: 0)
    SimpleEntry(date: .now, frameIndex: 1)
    SimpleEntry(date: .now, frameIndex: 2)
    SimpleEntry(date: .now, frameIndex: 3)
    SimpleEntry(date: .now, frameIndex: 4)
}
