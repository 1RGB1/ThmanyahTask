// 
//  SectionType.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum SectionType: String, Codable, Sendable {
    case square
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big_square"
    case queue
    
    static func from(apiValue: String) -> SectionType {
        let normalized = apiValue.replacingOccurrences(of: " ", with: "_").lowercased()
        switch normalized {
        case "square": return .square
        case "2_lines_grid": return .twoLinesGrid
        case "big_square": return .bigSquare
        case "queue": return .queue
        default: return .square
        }
    }
}

enum ContentType: String, Codable, Sendable {
    case podcast
    case episode
    case audioBook = "audio_book"
    case audioArticle = "audio_article"
    
    static func from(apiValue: String) -> ContentType {
        let normalized = apiValue.replacingOccurrences(of: " ", with: "_").lowercased()
        switch normalized {
        case "podcast": return .podcast
        case "episode": return .episode
        case "audio_book": return .audioBook
        case "audio_article": return .audioArticle
        default: return .podcast
        }
    }
}

enum SectionContentItem: Sendable {
    case podcast(PodcastContentModel)
    case episode(EpisodeContentModel)
    case audioBook(AudioBookContentModel)
    case audioArticle(AudioArticleContentModel)
}

struct SectionModel: Decodable, Sendable {
    let name: String
    let typeRaw: String
    let contentTypeRaw: String
    let order: Int
    let contentPodcast: [PodcastContentModel]?
    let contentEpisode: [EpisodeContentModel]?
    let contentAudioBook: [AudioBookContentModel]?
    let contentAudioArticle: [AudioArticleContentModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case content_type
        case order
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        typeRaw = try container.decode(String.self, forKey: .type)
        contentTypeRaw = try container.decode(String.self, forKey: .content_type)
        let orderValue = try OrderValue(from: container.superDecoder(forKey: .order))
        order = orderValue.intValue
        
        let contentType: ContentType = .from(apiValue: contentTypeRaw)
        switch contentType {
        case .podcast:
            contentPodcast = try? container.decode([PodcastContentModel].self, forKey: .content)
            contentEpisode = nil
            contentAudioBook = nil
            contentAudioArticle = nil
        case .episode:
            contentPodcast = nil
            contentEpisode = try? container.decode([EpisodeContentModel].self, forKey: .content)
            contentAudioBook = nil
            contentAudioArticle = nil
        case .audioBook:
            contentPodcast = nil
            contentEpisode = nil
            contentAudioBook = try? container.decode([AudioBookContentModel].self, forKey: .content)
            contentAudioArticle = nil
        case .audioArticle:
            contentPodcast = nil
            contentEpisode = nil
            contentAudioBook = nil
            contentAudioArticle = try? container.decode([AudioArticleContentModel].self, forKey: .content)
        }
    }
    
    private struct OrderValue: Codable {
        let intValue: Int
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let int = try? container.decode(Int.self) {
                intValue = int
            } else if let string = try? container.decode(String.self), let int = Int(string) {
                intValue = int
            } else {
                intValue = 0
            }
        }
    }
    
    var layoutType: SectionType { SectionType.from(apiValue: typeRaw) }
    var contentType: ContentType { ContentType.from(apiValue: contentTypeRaw) }
    var items: [SectionContentItem] {
        if let podcast = contentPodcast { return podcast.map { .podcast($0) } }
        if let episode = contentEpisode { return episode.map { .episode($0) } }
        if let audioBook = contentAudioBook { return audioBook.map { .audioBook($0) } }
        if let audioArticle = contentAudioArticle { return audioArticle.map { .audioArticle($0) } }
        return []
    }
    
    init(
        name: String,
        typeRaw: String,
        contentTypeRaw: String,
        order: Int,
        contentPodcast: [PodcastContentModel]? = nil,
        contentEpisode: [EpisodeContentModel]? = nil,
        contentAudioBook: [AudioBookContentModel]? = nil,
        contentAudioArticle: [AudioArticleContentModel]? = nil
    ) {
        self.name = name
        self.typeRaw = typeRaw
        self.contentTypeRaw = contentTypeRaw
        self.order = order
        self.contentPodcast = contentPodcast
        self.contentEpisode = contentEpisode
        self.contentAudioBook = contentAudioBook
        self.contentAudioArticle = contentAudioArticle
    }
}

struct SearchResponse: Decodable, Sendable {
    let sections: [SectionModel]
}
