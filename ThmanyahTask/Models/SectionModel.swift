//
//  SectionType.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import os

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
        default:
            logger.warning("Unknown section type: \(apiValue), falling back to .square")
            return .square
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
        default:
            logger.warning("Unknown content type: \(apiValue), falling back to .podcast")
            return .podcast
        }
    }
}

private let logger = Logger(subsystem: "com.thmanyah.task", category: "SectionModel")

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
    let items: [SectionContentItem]

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

        let sectionName = name
        let contentType: ContentType = .from(apiValue: contentTypeRaw)
        switch contentType {
        case .podcast:
            do {
                let models = try container.decode([PodcastContentModel].self, forKey: .content)
                items = models.map { .podcast($0) }
            } catch {
                logger.warning("Failed to decode podcast content for section '\(sectionName)': \(error.localizedDescription)")
                items = []
            }
        case .episode:
            do {
                let models = try container.decode([EpisodeContentModel].self, forKey: .content)
                items = models.map { .episode($0) }
            } catch {
                logger.warning("Failed to decode episode content for section '\(sectionName)': \(error.localizedDescription)")
                items = []
            }
        case .audioBook:
            do {
                let models = try container.decode([AudioBookContentModel].self, forKey: .content)
                items = models.map { .audioBook($0) }
            } catch {
                logger.warning("Failed to decode audioBook content for section '\(sectionName)': \(error.localizedDescription)")
                items = []
            }
        case .audioArticle:
            do {
                let models = try container.decode([AudioArticleContentModel].self, forKey: .content)
                items = models.map { .audioArticle($0) }
            } catch {
                logger.warning("Failed to decode audioArticle content for section '\(sectionName)': \(error.localizedDescription)")
                items = []
            }
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

    init(
        name: String,
        typeRaw: String,
        contentTypeRaw: String,
        order: Int,
        items: [SectionContentItem] = []
    ) {
        self.name = name
        self.typeRaw = typeRaw
        self.contentTypeRaw = contentTypeRaw
        self.order = order
        self.items = items
    }
}

struct SearchResponse: Decodable, Sendable {
    let sections: [SectionModel]
}
