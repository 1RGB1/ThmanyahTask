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
        episodeCount = FlexibleDecode.int(from: container, forKey: .episodeCount)
        duration = FlexibleDecode.int(from: container, forKey: .duration)
        language = try? container.decode(String.self, forKey: .language)
        priority = FlexibleDecode.int(from: container, forKey: .priority)
        popularityScore = FlexibleDecode.int(from: container, forKey: .popularityScore)
        score = FlexibleDecode.double(from: container, forKey: .score)
    }

    init(
        podcastId: String,
        name: String,
        description: String? = nil,
        avatarUrl: String? = nil,
        episodeCount: Int? = nil,
        duration: Int? = nil,
        language: String? = nil,
        priority: Int? = nil,
        popularityScore: Int? = nil,
        score: Double? = nil
    ) {
        self.podcastId = podcastId
        self.name = name
        self.description = description
        self.avatarUrl = avatarUrl
        self.episodeCount = episodeCount
        self.duration = duration
        self.language = language
        self.priority = priority
        self.popularityScore = popularityScore
        self.score = score
    }
}
