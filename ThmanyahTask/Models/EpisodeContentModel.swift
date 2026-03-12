// 
//  EpisodeContentModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

struct EpisodeContentModel: Codable, Sendable {
    let episodeId: String
    let name: String
    let podcastName: String?
    let authorName: String?
    let description: String?
    let duration: Int?
    let avatarUrl: String?
    let audioUrl: String?
    let releaseDate: String?
    let podcastId: String?
    
    enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case name
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case description
        case duration
        case avatarUrl = "avatar_url"
        case audioUrl = "audio_url"
        case releaseDate = "release_date"
        case podcastId = "podcast_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        episodeId = try container.decode(String.self, forKey: .episodeId)
        name = try container.decode(String.self, forKey: .name)
        podcastName = try? container.decode(String.self, forKey: .podcastName)
        authorName = try? container.decode(String.self, forKey: .authorName)
        description = try? container.decode(String.self, forKey: .description)
        duration = try? container.decode(Int?.self, forKey: .duration) ?? (try? container.decode(String.self, forKey: .duration)).flatMap(Int.init)
        avatarUrl = try? container.decode(String.self, forKey: .avatarUrl)
        audioUrl = try? container.decode(String.self, forKey: .audioUrl)
        releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        podcastId = try container.decode(String.self, forKey: .podcastId)
    }
}
