// 
//  ContentItemDisplay.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

struct ContentItemDisplay: Sendable {
    let title: String
    let subtitle: String?
    let imageUrl: URL?
    let duration: String?
    let authorName: String?
    
    static func from(_ item: SectionContentItem) -> ContentItemDisplay {
        switch item {
        case .podcast(let podcast):
            return ContentItemDisplay(
                title: podcast.name,
                subtitle: podcast.description,
                imageUrl: podcast.avatarUrl.flatMap { URL(string: $0) },
                duration: DurationFormatter.format(second: podcast.duration),
                authorName: nil
            )
            
        case .episode(let episode):
            return ContentItemDisplay(
                title: episode.name,
                subtitle: episode.podcastName,
                imageUrl: episode.avatarUrl.flatMap { URL(string: $0) },
                duration: DurationFormatter.format(second: episode.duration),
                authorName: episode.authorName
            )
            
        case .audioBook(let audiobook):
            return ContentItemDisplay(
                title: audiobook.name,
                subtitle: audiobook.authorName,
                imageUrl: audiobook.avatarUrl.flatMap { URL(string: $0) },
                duration: DurationFormatter.format(second: audiobook.duration),
                authorName: audiobook.authorName
            )
            
        case .audioArticle(let audioArticle):
            return ContentItemDisplay(
                title: audioArticle.name,
                subtitle: audioArticle.authorName,
                imageUrl: audioArticle.avatarUrl.flatMap { URL(string: $0) },
                duration: DurationFormatter.format(second: audioArticle.duration),
                authorName: audioArticle.authorName
            )
        }
    }
}
