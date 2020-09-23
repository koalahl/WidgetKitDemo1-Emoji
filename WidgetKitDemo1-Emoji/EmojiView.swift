//
//  EmojiView.swift
//  WidgetKitDemo1-Emoji
//
//  Created by HanLiu on 2020/9/23.
//

import SwiftUI

struct EmojiView: View {
    let emoji: Emoji
    var body: some View {
        Text(emoji.icon).font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
    }
}
