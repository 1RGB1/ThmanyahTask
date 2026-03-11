// 
//  AudioBookContentModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

struct AudioBookContentModel: Codable, Sendable {
    let audiobookId: String?
    let name: String?
    let authorName: String?
    let description: String?
    let avatarUrl: String?
    let duration: Int?
    let language: String?
    let releaseDate: String?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case audiobookId = "audiobook_id"
        case name
        case authorName = "author_name"
        case description
        case avatarUrl = "avatar_url"
        case duration
        case language
        case releaseDate = "release_date"
        case score
    }
}
