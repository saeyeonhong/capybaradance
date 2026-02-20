//
//  CapybaraDanceWidget.swift
//  CapybaraDanceWidget
//
//  Created by Saeyeon Hong on 2/20/26.
//

import WidgetKit
import SwiftUI

// MARK: - Timeline Entry

struct SimpleEntry: TimelineEntry {
    let date: Date
    let frameIndex: Int
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
        let frameInterval: TimeInterval = 0.3
        let count = 300 // ~90 seconds of animation, then reload

        for i in 0..<count {
            let entryDate = startDate.addingTimeInterval(Double(i) * frameInterval)
            entries.append(SimpleEntry(date: entryDate, frameIndex: i % 5))
        }

        let reloadDate = startDate.addingTimeInterval(Double(count) * frameInterval)
        completion(Timeline(entries: entries, policy: .after(reloadDate)))
    }
}

// MARK: - Widget View

struct CapybaraDanceWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var imageSize: CGFloat {
        family == .systemSmall ? 80 : 120
    }

    var body: some View {
        ZStack {
            Color.white

            VStack(spacing: 6) {
                Image("capybara\(entry.frameIndex + 1)")
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)

                Text("♡ capybara ♡")
                    .font(.caption2.bold())
                    .foregroundStyle(.black)
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
            if #available(iOS 17.0, *) {
                CapybaraDanceWidgetEntryView(entry: entry)
                    .containerBackground(Color.white, for: .widget)
            } else {
                CapybaraDanceWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("Capybara Dance")
        .description("Watch a capybara groove on your home screen!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

