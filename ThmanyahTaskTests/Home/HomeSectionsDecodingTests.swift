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
}
