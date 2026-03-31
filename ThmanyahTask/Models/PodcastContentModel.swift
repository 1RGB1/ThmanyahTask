// 
//  PodcastContentModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

struct PodcastContentModel: Codable, Sendable {
    let podcastId: String
    let name: String
    let description: String?
    let avatarUrl: String?
    let episodeCount: Int?
    let duration: Int?
    let language: String?
    let priority: Int?
    let popularityScore: Int?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case podcastId = "podcast_id"
        case name
        case description
        case avatarUrl = "avatar_url"
        case episodeCount = "episode_count"
        case duration
        case language
        case priority
        case popularityScore
        case score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        podcastId = try container.decode(String.self, forKey: .podcastId)
        name = try container.decode(String.self, forKey: .name)
        description = try? container.decode(String.self, forKey: .description)
        avatarUrl = try? container.decode(String.self, forKey: .avatarUrl)
        episodeCount = try? container.decode(Int?.self, forKey: .episodeCount) ?? (try? container.decode(String.self, forKey: .episodeCount)).flatMap(Int.init)
        duration = try? container.decode(Int?.self, forKey: .duration) ?? (try? container.decode(String.self, forKey: .duration)).flatMap(Int.init)
        language = try? container.decode(String.self, forKey: .language)
        priority = try? container.decode(Int?.self, forKey: .priority) ?? (try? container.decode(String.self, forKey: .priority)).flatMap(Int.init)
        popularityScore = try? container.decode(Int?.self, forKey: .popularityScore) ?? (try? container.decode(String.self, forKey: .popularityScore)).flatMap(Int.init)
        score = try? container.decode(Double?.self, forKey: .score) ?? (try? container.decode(String.self, forKey: .score)).flatMap(Double.init)
    }
}
