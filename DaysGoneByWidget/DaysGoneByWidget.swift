//
//  DaysGoneByWidget.swift
//  DaysGoneByWidget
//
//  Created by Christopher Erdos on 10/6/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
	func placeholder(in context: Context) -> SimpleEntry {
		return SimpleEntry(date: UserDefaults.mine.getTime() ?? Date())
	}
	
	func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
		let entry = SimpleEntry(date: UserDefaults.mine.getTime() ?? Date())
		completion(entry)
	}
	
	func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
		let entries: [SimpleEntry] = [SimpleEntry(date: UserDefaults.mine.getTime() ?? Date())]
		let currentDate = Date()
		let loadAfterDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
		let timeline = Timeline(entries: entries, policy: .after(loadAfterDate))
		completion(timeline)
	}
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

@main
struct DaysGoneByWidget: Widget {
    let kind: String = "DaysGoneByWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
			WidgetView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct DaysGoneByWidget_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			WidgetView(entry: SimpleEntry(date: Date().addingTimeInterval(-350000000)))
				.previewContext(WidgetPreviewContext(family: .systemSmall))
			WidgetView(entry: SimpleEntry(date: Date().addingTimeInterval(-350000000)))
				.previewContext(WidgetPreviewContext(family: .systemSmall))
		}
    }
}

struct WidgetView: View {
	var entry: SimpleEntry
	
	var body: some View {
		VStack {
			Text(entry.date, style: .relative)
				.padding()
				.multilineTextAlignment(.leading)
				.padding()
				.font(.title)
		}.opacity(0.6)
	}
}
