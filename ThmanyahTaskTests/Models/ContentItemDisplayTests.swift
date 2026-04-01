//
//  ContentItemDisplayTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

struct ContentItemDisplayTests {

    @Test func fromPodcastMapsCorrectly() {
        let podcast = PodcastContentModel(
            podcastId: "p1",
            name: "Test Podcast",
            description: "A description",
            avatarUrl: "https://example.com/image.png",
            duration: 600
        )
        let display = ContentItemDisplay.from(.podcast(podcast))
        #expect(display.title == "Test Podcast")
        #expect(display.subtitle == "A description")
        #expect(display.imageUrl?.absoluteString == "https://example.com/image.png")
        #expect(display.duration == "10m")
        #expect(display.authorName == nil)
    }

    @Test func fromEpisodeMapsCorrectly() {
        let episode = EpisodeContentModel(
            episodeId: "e1",
            name: "Test Episode",
            podcastName: "My Podcast",
            authorName: "Author",
            duration: 3661,
            avatarUrl: "https://example.com/ep.png"
        )
        let display = ContentItemDisplay.from(.episode(episode))
        #expect(display.title == "Test Episode")
        #expect(display.subtitle == "My Podcast")
        #expect(display.duration == "1h 1m 1s")
        #expect(display.authorName == "Author")
    }

    @Test func fromAudioBookMapsCorrectly() {
        let book = AudioBookContentModel(
            audiobookId: "ab1",
            name: "Test Book",
            authorName: "Book Author",
            avatarUrl: "https://example.com/book.png",
            duration: 7200
        )
        let display = ContentItemDisplay.from(.audioBook(book))
        #expect(display.title == "Test Book")
        #expect(display.subtitle == "Book Author")
        #expect(display.duration == "2h")
        #expect(display.authorName == "Book Author")
    }

    @Test func fromAudioArticleMapsCorrectly() {
        let article = AudioArticleContentModel(
            articleId: "art1",
            name: "Test Article",
            authorName: "Article Author",
            duration: 300
        )
        let display = ContentItemDisplay.from(.audioArticle(article))
        #expect(display.title == "Test Article")
        #expect(display.subtitle == "Article Author")
        #expect(display.duration == "5m")
        #expect(display.authorName == "Article Author")
    }

    @Test func nilAvatarUrlProducesNilImageUrl() {
        let podcast = PodcastContentModel(
            podcastId: "p1",
            name: "No Image",
            avatarUrl: nil
        )
        let display = ContentItemDisplay.from(.podcast(podcast))
        #expect(display.imageUrl == nil)
    }

    @Test func nilDurationProducesEmptyString() {
        let podcast = PodcastContentModel(
            podcastId: "p1",
            name: "No Duration",
            duration: nil
        )
        let display = ContentItemDisplay.from(.podcast(podcast))
        #expect(display.duration == "")
    }
}
