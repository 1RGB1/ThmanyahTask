//
//  ContentModelDecodingTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

struct ContentModelDecodingTests {

    // MARK: - PodcastContentModel

    @Test func podcastDecodesIntFields() throws {
        let json = Data("""
        {
            "podcast_id": "p1",
            "name": "Test",
            "episode_count": 10,
            "duration": 600,
            "priority": 1,
            "popularityScore": 5,
            "score": 4.5
        }
        """.utf8)
        let podcast = try JSONDecoder().decode(PodcastContentModel.self, from: json)
        #expect(podcast.episodeCount == 10)
        #expect(podcast.duration == 600)
        #expect(podcast.priority == 1)
        #expect(podcast.popularityScore == 5)
        #expect(podcast.score == 4.5)
    }

    @Test func podcastDecodesStringFields() throws {
        let json = Data("""
        {
            "podcast_id": "p1",
            "name": "Test",
            "episode_count": "10",
            "duration": "600",
            "priority": "1",
            "popularityScore": "5",
            "score": "4.5"
        }
        """.utf8)
        let podcast = try JSONDecoder().decode(PodcastContentModel.self, from: json)
        #expect(podcast.episodeCount == 10)
        #expect(podcast.duration == 600)
        #expect(podcast.priority == 1)
        #expect(podcast.popularityScore == 5)
        #expect(podcast.score == 4.5)
    }

    @Test func podcastHandlesMissingOptionalFields() throws {
        let json = Data("""
        {
            "podcast_id": "p1",
            "name": "Minimal"
        }
        """.utf8)
        let podcast = try JSONDecoder().decode(PodcastContentModel.self, from: json)
        #expect(podcast.podcastId == "p1")
        #expect(podcast.name == "Minimal")
        #expect(podcast.description == nil)
        #expect(podcast.avatarUrl == nil)
        #expect(podcast.episodeCount == nil)
        #expect(podcast.duration == nil)
        #expect(podcast.score == nil)
    }

    // MARK: - EpisodeContentModel

    @Test func episodeDecodesCorrectly() throws {
        let json = Data("""
        {
            "episode_id": "e1",
            "name": "Episode",
            "podcast_name": "Podcast",
            "author_name": "Author",
            "duration": 1800,
            "avatar_url": "https://example.com/ep.png",
            "audio_url": "https://example.com/ep.mp3",
            "release_date": "2026-01-01",
            "podcast_id": "p1"
        }
        """.utf8)
        let episode = try JSONDecoder().decode(EpisodeContentModel.self, from: json)
        #expect(episode.episodeId == "e1")
        #expect(episode.name == "Episode")
        #expect(episode.podcastName == "Podcast")
        #expect(episode.authorName == "Author")
        #expect(episode.duration == 1800)
        #expect(episode.audioUrl == "https://example.com/ep.mp3")
    }

    @Test func episodeDurationFromString() throws {
        let json = Data("""
        {
            "episode_id": "e1",
            "name": "Episode",
            "duration": "900",
            "podcast_id": "p1"
        }
        """.utf8)
        let episode = try JSONDecoder().decode(EpisodeContentModel.self, from: json)
        #expect(episode.duration == 900)
    }

    // MARK: - AudioBookContentModel

    @Test func audioBookDecodesCorrectly() throws {
        let json = Data("""
        {
            "audiobook_id": "ab1",
            "name": "Book",
            "author_name": "Author",
            "duration": 7200,
            "score": 4.8
        }
        """.utf8)
        let book = try JSONDecoder().decode(AudioBookContentModel.self, from: json)
        #expect(book.audiobookId == "ab1")
        #expect(book.name == "Book")
        #expect(book.duration == 7200)
        #expect(book.score == 4.8)
    }

    @Test func audioBookScoreFromString() throws {
        let json = Data("""
        {
            "audiobook_id": "ab1",
            "name": "Book",
            "score": "3.9"
        }
        """.utf8)
        let book = try JSONDecoder().decode(AudioBookContentModel.self, from: json)
        #expect(book.score == 3.9)
    }

    @Test func audioBookDurationFromString() throws {
        let json = Data("""
        {
            "audiobook_id": "ab1",
            "name": "Book",
            "duration": "3600"
        }
        """.utf8)
        let book = try JSONDecoder().decode(AudioBookContentModel.self, from: json)
        #expect(book.duration == 3600)
    }

    // MARK: - AudioArticleContentModel

    @Test func audioArticleDecodesCorrectly() throws {
        let json = Data("""
        {
            "article_id": "art1",
            "name": "Article",
            "author_name": "Writer",
            "duration": 600,
            "score": 4.2
        }
        """.utf8)
        let article = try JSONDecoder().decode(AudioArticleContentModel.self, from: json)
        #expect(article.articleId == "art1")
        #expect(article.name == "Article")
        #expect(article.duration == 600)
        #expect(article.score == 4.2)
    }

    @Test func audioArticleScoreFromString() throws {
        let json = Data("""
        {
            "article_id": "art1",
            "name": "Article",
            "score": "3.5"
        }
        """.utf8)
        let article = try JSONDecoder().decode(AudioArticleContentModel.self, from: json)
        #expect(article.score == 3.5)
    }

    @Test func audioArticleDurationFromString() throws {
        let json = Data("""
        {
            "article_id": "art1",
            "name": "Article",
            "duration": "300"
        }
        """.utf8)
        let article = try JSONDecoder().decode(AudioArticleContentModel.self, from: json)
        #expect(article.duration == 300)
    }
}
