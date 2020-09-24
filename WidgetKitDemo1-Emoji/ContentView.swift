//
//  ContentView.swift
//  WidgetKitDemo1-Emoji
//
//  Created by HanLiu on 2020/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.levihan.WidgetKitDemo1Emoji"))
    var emojiData = Data()
    
    let emojis = [
        Emoji(icon: "😄", name: "happy", description: "This is a happy description ha"),
        Emoji(icon: "😂", name: "shyme", description: "This is a shyme description."),
        Emoji(icon: "🏠", name: "family", description: "This is a family description"),
    ]
    var body: some View {
        VStack {
            ForEach(emojis) { emoji in
                EmojiView(emoji: emoji).onTapGesture{
                    save(emoji)
                }
            }
        }
        Text(emojiData.description)
    }
    
    func save(_ emoji: Emoji) {
        guard let emojiData = try? JSONEncoder().encode(emoji) else { return }
//        if let defaults = UserDefaults(suiteName: "group.com.levihan.WidgetKitDemo1-Emoji") {
//            defaults.setValue(emojiData, forKey: "emoji")
//            defaults.synchronize()
//            print("save to UserDefaults \(emojiData.count)")
//        }
        self.emojiData = emojiData
        print("save \(emoji)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
