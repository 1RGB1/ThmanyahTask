//
//  MockHomeService.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
@testable import ThmanyahTask

final class MockHomeService: HomeServiceProtocol {
    private var results: (sections: [SectionModel], nextPage: Int?)?
    private var pageResults: [Int: (sections: [SectionModel], nextPage: Int?)]?
    private let error: Error?
    private let errorOnPage: Int?

    init(
        results: (sections: [SectionModel], nextPage: Int?)? = nil,
        error: Error? = nil
    ) {
        self.results = results
        self.error = error
        self.pageResults = nil
        self.errorOnPage = nil
    }

    init(
        pageResults: [Int: (sections: [SectionModel], nextPage: Int?)],
        errorOnPage: Int? = nil
    ) {
        self.pageResults = pageResults
        self.results = nil
        self.error = nil
        self.errorOnPage = errorOnPage
    }

    func updateResults(_ newResults: (sections: [SectionModel], nextPage: Int?)) {
        results = newResults
    }

    func fetchSections(page: Int) async throws -> (sections: [SectionModel], nextPage: Int?) {
        if let errorOnPage, page == errorOnPage {
            throw NSError(domain: "Mock", code: -1, userInfo: [NSLocalizedDescriptionKey: "Page load failed"])
        }
        if let error { throw error }
        if let pageResults, let result = pageResults[page] {
            return result
        }
        guard let results else {
            throw NSError(domain: "Mock", code: -1, userInfo: nil)
        }
        return results
    }
}
