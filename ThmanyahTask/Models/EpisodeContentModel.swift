// 
//  EpisodeContentModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

struct EpisodeContentModel: Codable, Sendable {
    let episodeId: String?
    let name: String?
    let podcastId: String?
    let seasonNumber: Int?
    let episodeType: String?
    let podcastName: String?
    let authorName: String?
    let description: String?
    let number: Int?
    let duration: Int?
    let avatarUrl: String?
    let separatedAudioUrl: String?
    let audioUrl: String?
    let releaseDate: String?
    let podcastPopularityScore: Int?
    let podcastPriority: Int?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case name
        case podcastId = "podcast_id"
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case description
        case number
        case duration
        case avatarUrl = "avatar_url"
        case separatedAudioUrl = "separated_audio_url"
        case audioUrl = "audio_url"
        case releaseDate = "release_date"
        case podcastPopularityScore
        case podcastPriority
        case score
    }
}
