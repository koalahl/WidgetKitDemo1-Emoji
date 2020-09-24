//
//  EmojiWidget.swift
//  EmojiWidget
//
//  Created by HanLiu on 2020/9/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.levihan.WidgetKitDemo1Emoji"))
    var emojiData:Data = Data()
    
    func placeholder(in context: Context) -> EmojiEntry {

        EmojiEntry(emoji: Emoji(icon: "", name: "N/A", description: "N/A"))
    }

    func getSnapshot(in context: Context, completion: @escaping (EmojiEntry) -> ()) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData ) else {return}
        let entry = EmojiEntry(emoji: emoji)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [EmojiEntry] = []
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else {return}

        let entry = EmojiEntry(emoji: emoji)
        entries.append(entry)
        

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct EmojiEntry: TimelineEntry {
    let date: Date = Date()
    let emoji: Emoji
}

struct EmojiWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            EmojiView(emoji: entry.emoji)
        case .systemMedium:
            HStack (spacing: 30){
                EmojiView(emoji: entry.emoji)
                Text(entry.emoji.name).font(.largeTitle)
            }
        default:
            VStack(spacing:30) {
                HStack (spacing: 30){
                    EmojiView(emoji: entry.emoji)
                    Text(entry.emoji.name).font(.largeTitle)
                }
                Text(entry.emoji.description).font(.title2)
            }
        }
    }
}

struct PlaceholderView: View {
    var body: some View {
        EmojiView(emoji: Emoji(icon: "🌶️", name: "hot", description: "N/A"))
    }
}

@main
struct EmojiWidget: Widget {
    let kind: String = "EmojiWidget"

    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EmojiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

struct EmojiWidget_Previews: PreviewProvider {
    static var previews: some View {

        EmojiWidgetEntryView(entry: EmojiEntry(emoji: Emoji(icon: "😊", name: "laugh", description: "N/A")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
