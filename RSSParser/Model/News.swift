//
//  News.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation

struct RSS: Codable {
    var channel: Channel
}

struct Channel: Codable {
    var title: String
    var item: [News]
}

struct News: Codable {
    var title: String
    var pubDate: String
    var enclosure: [Enclosure]?
    var fullText: String
    var category: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case pubDate
        case enclosure
        case category
        case fullText = "yandex:full-text"
    }
}

struct Enclosure: Codable {
    var url: String?
    var type: String?
}
