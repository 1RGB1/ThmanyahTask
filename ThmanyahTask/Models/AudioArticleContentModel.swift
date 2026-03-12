// 
//  AudioArticleContentModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

struct AudioArticleContentModel: Codable, Sendable {
    let articleId: String
    let name: String
    let authorName: String?
    let description: String?
    let avatarUrl: String?
    let duration: Int?
    let releaseDate: String?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
        case name
        case authorName = "author_name"
        case description
        case avatarUrl = "avatar_url"
        case duration
        case releaseDate = "release_date"
        case score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        articleId = try container.decode(String.self, forKey: .articleId)
        name = try container.decode(String.self, forKey: .name)
        authorName = try? container.decode(String.self, forKey: .authorName)
        description = try? container.decode(String.self, forKey: .description)
        avatarUrl = try? container.decode(String.self, forKey: .avatarUrl)
        duration = try? container.decode(Int?.self, forKey: .duration) ?? (try? container.decode(String.self, forKey: .duration)).flatMap(Int.init)
        releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        score = try? container.decode(Double?.self, forKey: .score) ?? (try? container.decode(String.self, forKey: .duration)).flatMap(Double.init)
        
    }
}
