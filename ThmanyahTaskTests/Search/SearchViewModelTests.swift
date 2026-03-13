// 
//  SearchViewModelTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

@MainActor
struct SearchViewModelTests {

    private func makeSection(name: String = "Test Section") -> SectionModel {
        SectionModel(
            name: name,
            typeRaw: "square",
            contentTypeRaw: "podcast",
            order: 1,
            contentPodcast: [],
            contentEpisode: nil,
            contentAudioBook: nil,
            contentAudioArticle: nil
        )
    }

    @Test func retryWithEmptyQueryDoesNothing() async throws {
        let section = makeSection()
        let mockService = MockSearchService(results: [section])
        let viewModel = SearchViewModel(service: mockService)
        
        viewModel.searchText = ""
        viewModel.retry()
        
        try await Task.sleep(nanoseconds: 50_000_000)
        #expect(viewModel.sections.isEmpty, "Expected empty sections")
        #expect(viewModel.loadingState == .idle, "Expected idle state")
    }
    
    @Test func retryWithQueryRunsSearchAndUpudatesState() async throws {
        let section = makeSection()
        let mockService = MockSearchService(results: [section])
        let viewModel = SearchViewModel(service: mockService)
        
        viewModel.searchText = "test"
        viewModel.retry()
        
        try await Task.sleep(nanoseconds: 300_000_000)
        if case .loaded = viewModel.loadingState {
            #expect(viewModel.sections.count == 1, "Expected only one section")
            #expect(viewModel.sections[0].name == "Test Section", "Expected section name to match")
        } else {
            Issue.record("Expected loaded state, got \(viewModel.loadingState)")
        }
    }
    
    @Test func retryOnErrorSetsErrorState() async throws {
        let mockService = MockSearchService(error: NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Search failed"]))
        let viewModel = SearchViewModel(service: mockService)
        
        viewModel.searchText = "test"
        viewModel.retry()
        
        try await Task.sleep(nanoseconds: 300_000_000)
        if case .error(let message) = viewModel.loadingState {
            #expect(message == "Search failed")
        } else {
            Issue.record("Expected error state, got \(viewModel.loadingState)")
        }
    }
}
