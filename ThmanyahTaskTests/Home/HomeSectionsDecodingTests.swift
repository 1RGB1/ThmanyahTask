//
//  HomeSectionsDecodingTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

@MainActor
struct HomeSectionsDecodingTests {

    @Test func decodeHomeSectionsResponse() throws {
        let json = """
        {
            "sections": [
                {
                    "name": "Top Podcasts",
                    "type": "square",
                    "content_type": "podcast",
                    "order": 1,
                    "content": [
                        {
                           "podcast_id": "33223131",
                           "name": "NPR News Now",
                           "description": "The latest news in five minutes. Updated hourly.",
                           "avatar_url": "https://media.npr.org/assets/img/2023/03/01/npr-news-now_square.png?s=1400&c=66",
                           "episode_count": 2,
                           "duration": 600,
                           "priority": 1,
                           "popularityScore": 11,
                           "score": 240.0845
                        }
                    ]
                }
            ],
            "pagination": {
                "next_page": "/home_sections?page=2",
                "total_pages": 10
            }
        }
        """

        let data = Data(json.utf8)
        let decoder = JSONDecoder()
        let response = try decoder.decode(HomeModel.self, from: data)
        #expect(response.sections.count == 1)

        #expect(response.sections[0].name == "Top Podcasts")
        #expect(response.sections[0].layoutType == .square)
        #expect(response.sections[0].order == 1)
        #expect(response.sections[0].items.count == 1)
        #expect(response.pagination?.nextPage == "/home_sections?page=2")
        #expect(response.pagination?.totalPages == 10)
    }

    @Test func sectionLayoutTypeNormalizes() {
        #expect(SectionType.from(apiValue: "big square") == .bigSquare)
        #expect(SectionType.from(apiValue: "big_square") == .bigSquare)
        #expect(SectionType.from(apiValue: "square") == .square)
        #expect(SectionType.from(apiValue: "2_lines_grid") == .twoLinesGrid)
        #expect(SectionType.from(apiValue: "queue") == .queue)
    }

    @Test func unknownSectionTypeDefaultsToSquare() {
        #expect(SectionType.from(apiValue: "unknown_type") == .square)
    }

    @Test func contentTypeNormalizes() {
        #expect(ContentType.from(apiValue: "podcast") == .podcast)
        #expect(ContentType.from(apiValue: "episode") == .episode)
        #expect(ContentType.from(apiValue: "audio_book") == .audioBook)
        #expect(ContentType.from(apiValue: "audio book") == .audioBook)
        #expect(ContentType.from(apiValue: "audio_article") == .audioArticle)
    }

    @Test func unknownContentTypeDefaultsToPodcast() {
        #expect(ContentType.from(apiValue: "unknown_content") == .podcast)
    }

    @Test func orderDecodesFromString() throws {
        let json = """
        {
            "sections": [
                {
                    "name": "Test",
                    "type": "square",
                    "content_type": "podcast",
                    "order": "3",
                    "content": []
                }
            ]
        }
        """
        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(HomeModel.self, from: data)
        #expect(response.sections[0].order == 3)
    }

    @Test func orderDecodesFromInt() throws {
        let json = """
        {
            "sections": [
                {
                    "name": "Test",
                    "type": "square",
                    "content_type": "podcast",
                    "order": 5,
                    "content": []
                }
            ]
        }
        """
        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(HomeModel.self, from: data)
        #expect(response.sections[0].order == 5)
    }

    @Test func decodeEpisodeSection() throws {
        let json = """
        {
            "sections": [
                {
                    "name": "Latest Episodes",
                    "type": "2_lines_grid",
                    "content_type": "episode",
                    "order": 2,
                    "content": [
                        {
                            "episode_id": "ep1",
                            "name": "Episode One",
                            "podcast_name": "Test Podcast",
                            "duration": 1800,
                            "podcast_id": "pod1"
                        }
                    ]
                }
            ]
        }
        """
        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(HomeModel.self, from: data)
        #expect(response.sections[0].items.count == 1)
        #expect(response.sections[0].layoutType == .twoLinesGrid)
        #expect(response.sections[0].contentType == .episode)
    }

    @Test func decodeAudioBookSection() throws {
        let json = """
        {
            "sections": [
                {
                    "name": "Audiobooks",
                    "type": "big_square",
                    "content_type": "audio_book",
                    "order": 3,
                    "content": [
                        {
                            "audiobook_id": "ab1",
                            "name": "Book One",
                            "author_name": "Author",
                            "duration": 3600,
                            "score": 4.5
                        }
                    ]
                }
            ]
        }
        """
        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(HomeModel.self, from: data)
        #expect(response.sections[0].items.count == 1)
        if case .audioBook(let book) = response.sections[0].items[0] {
            #expect(book.name == "Book One")
            #expect(book.score == 4.5)
            #expect(book.duration == 3600)
        } else {
            Issue.record("Expected audioBook content item")
        }
    }

    @Test func decodeAudioArticleSection() throws {
        let json = """
        {
            "sections": [
                {
                    "name": "Articles",
                    "type": "queue",
                    "content_type": "audio_article",
                    "order": 4,
                    "content": [
                        {
                            "article_id": "art1",
                            "name": "Article One",
                            "author_name": "Writer",
                            "duration": "900",
                            "score": "3.8"
                        }
                    ]
                }
            ]
        }
        """
        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(HomeModel.self, from: data)
        #expect(response.sections[0].items.count == 1)
        if case .audioArticle(let article) = response.sections[0].items[0] {
            #expect(article.name == "Article One")
            #expect(article.duration == 900)
            #expect(article.score == 3.8)
        } else {
            Issue.record("Expected audioArticle content item")
        }
    }

    @Test func paginationDecodesTotalPagesFromString() throws {
        let json = """
        {
            "sections": [],
            "pagination": {
                "next_page": "/home_sections?page=2",
                "total_pages": "5"
            }
        }
        """
        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(HomeModel.self, from: data)
        #expect(response.pagination?.totalPages == 5)
    }

    @Test func missingPaginationDecodesAsNil() throws {
        let json = """
        {
            "sections": []
        }
        """
        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(HomeModel.self, from: data)
        #expect(response.pagination == nil)
    }
}
