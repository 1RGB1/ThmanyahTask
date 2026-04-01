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

    private func makeSection(name: String = "Test Section") -> SectionModel {
        SectionModel(
            name: name,
            typeRaw: "square",
            contentTypeRaw: "podcast",
            order: 1,
            items: []
        )
    }

    @Test func loadInitialPopulatesSections() async throws {
        let section = makeSection()
        let mockService = MockHomeService(results: (sections: [section], nextPage: nil))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        #expect(viewModel.sections.count == 1)
        #expect(viewModel.sections[0].name == "Test Section")
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

    @Test func loadInitialSetsLoadedState() async throws {
        let section = makeSection()
        let mockService = MockHomeService(results: (sections: [section], nextPage: nil))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        #expect(viewModel.loadingState == .loaded)
    }

    @Test func loadInitialWithNextPageSetsNextPage() async throws {
        let section = makeSection()
        let mockService = MockHomeService(results: (sections: [section], nextPage: 2))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        #expect(viewModel.nextPage == 2)
    }

    @Test func loadInitialWithNoNextPageClearsNextPage() async throws {
        let section = makeSection()
        let mockService = MockHomeService(results: (sections: [section], nextPage: nil))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        #expect(viewModel.nextPage == nil)
    }

    @Test func loadNextPageIfNeededDoesNothingWhenNotLoaded() async throws {
        let section = makeSection()
        let mockService = MockHomeService(results: (sections: [section], nextPage: 2))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadNextPageIfNeeded(currentSectionIndex: 0)
        #expect(viewModel.sections.isEmpty)
    }

    @Test func loadNextPageIfNeededDoesNothingWhenNoNextPage() async throws {
        let section = makeSection()
        let mockService = MockHomeService(results: (sections: [section], nextPage: nil))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        await viewModel.loadNextPageIfNeeded(currentSectionIndex: 0)
        #expect(viewModel.sections.count == 1)
    }

    @Test func loadNextPageIfNeededAppendsSections() async throws {
        let page1Section = makeSection(name: "Page 1")
        let page2Section = makeSection(name: "Page 2")
        let mockService = MockHomeService(
            pageResults: [
                1: (sections: [page1Section], nextPage: 2),
                2: (sections: [page2Section], nextPage: nil)
            ]
        )
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        #expect(viewModel.sections.count == 1)
        await viewModel.loadNextPageIfNeeded(currentSectionIndex: 0)
        #expect(viewModel.sections.count == 2)
        #expect(viewModel.sections[1].name == "Page 2")
    }

    @Test func loadNextPageOnErrorSetsTryAgainState() async throws {
        let section = makeSection()
        let mockService = MockHomeService(
            pageResults: [1: (sections: [section], nextPage: 2)],
            errorOnPage: 2
        )
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        await viewModel.loadNextPageIfNeeded(currentSectionIndex: 0)
        #expect(viewModel.loadingState == .tryAgain)
    }

    @Test func loadInitialClearsPreviousSections() async throws {
        let section1 = makeSection(name: "First")
        let section2 = makeSection(name: "Second")
        let mockService = MockHomeService(results: (sections: [section1], nextPage: nil))
        let viewModel = HomeViewModel(service: mockService)
        await viewModel.loadInitial()
        #expect(viewModel.sections.count == 1)

        mockService.updateResults((sections: [section2], nextPage: nil))
        await viewModel.loadInitial()
        #expect(viewModel.sections.count == 1)
        #expect(viewModel.sections[0].name == "Second")
    }
}
