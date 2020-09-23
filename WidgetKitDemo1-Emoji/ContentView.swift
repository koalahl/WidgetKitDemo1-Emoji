//
//  ContentView.swift
//  WidgetKitDemo1-Emoji
//
//  Created by HanLiu on 2020/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.levihan.WidgetKitDemo1-Emoji"))
    var emojiData = Data()
    
    let emojis = [
        Emoji(icon: "😄", name: "happy", description: "this is a happy description"),
        Emoji(icon: "😂", name: "shyme", description: "this is a shyme description"),
        Emoji(icon: "🏠", name: "family", description: "this is a family description"),
    ]
    var body: some View {
        VStack {
            ForEach(emojis) { emoji in
                EmojiView(emoji: emoji).onTapGesture{
                    save(emoji)
                }
            }
        }
    }
    
    func save(_ emoji: Emoji) {
        guard let emojiData = try? JSONEncoder().encode(emoji) else { return }
        self.emojiData = emojiData
        print("save \(emoji)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
