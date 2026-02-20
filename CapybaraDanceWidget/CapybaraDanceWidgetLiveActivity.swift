//
//  CapybaraDanceWidgetLiveActivity.swift
//  CapybaraDanceWidget
//
//  Created by Saeyeon Hong on 2/20/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CapybaraDanceWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CapybaraDanceWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CapybaraDanceWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CapybaraDanceWidgetAttributes {
    fileprivate static var preview: CapybaraDanceWidgetAttributes {
        CapybaraDanceWidgetAttributes(name: "World")
    }
}

extension CapybaraDanceWidgetAttributes.ContentState {
    fileprivate static var smiley: CapybaraDanceWidgetAttributes.ContentState {
        CapybaraDanceWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CapybaraDanceWidgetAttributes.ContentState {
         CapybaraDanceWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CapybaraDanceWidgetAttributes.preview) {
   CapybaraDanceWidgetLiveActivity()
} contentStates: {
    CapybaraDanceWidgetAttributes.ContentState.smiley
    CapybaraDanceWidgetAttributes.ContentState.starEyes
}
