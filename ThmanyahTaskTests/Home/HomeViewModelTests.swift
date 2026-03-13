// 
//  HomeViewModelTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

@MainActor
struct HomeViewModelTests {

    @Test func loadInitialPopulatesSections() async throws {
        let section = SectionModel(
            name: "Test Section",
            typeRaw: "square",
            contentTypeRaw: "podcast",
            order: 1,
            contentPodcast: [],
            contentEpisode: nil,
            contentAudioBook: nil,
            contentAudioArticle: nil
        )
        
        let mockService = MockHomeService(results: (sections: [section], nextPage: nil))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        #expect(viewModel.sections.count == 1, "Expected only one element")
        #expect(viewModel.sections[0].name == "Test Section", "Expected section name to match")
    }

    @Test func loadInitialOnErrorSetsErrorState() async throws {
        let mockService = MockHomeService(error: NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"]))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        if case .error(let message) = viewModel.loadingState {
            #expect(message == "Network error")
        } else {
            Issue.record("Expected error state")
        }
    }
}
