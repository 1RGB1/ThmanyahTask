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
        duration = FlexibleDecode.int(from: container, forKey: .duration)
        releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        score = FlexibleDecode.double(from: container, forKey: .score)
    }

    init(
        articleId: String,
        name: String,
        authorName: String? = nil,
        description: String? = nil,
        avatarUrl: String? = nil,
        duration: Int? = nil,
        releaseDate: String? = nil,
        score: Double? = nil
    ) {
        self.articleId = articleId
        self.name = name
        self.authorName = authorName
        self.description = description
        self.avatarUrl = avatarUrl
        self.duration = duration
        self.releaseDate = releaseDate
        self.score = score
    }
}
