//
//  File.swift
//  WidgetKitDemo1-Emoji
//
//  Created by HanLiu on 2020/9/23.
//

import Foundation

struct Emoji : Identifiable, Codable {
    let icon: String
    let name: String
    let description: String
    
    var id: String { icon }
}
