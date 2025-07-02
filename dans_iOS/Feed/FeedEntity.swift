//
//  FeedEntity.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import Foundation

struct FeedEntityList: Codable {
    let id, author: String?
    let width, height: Int?
    let url, download_url: String?
    var isBookmarked: Bool?
}
