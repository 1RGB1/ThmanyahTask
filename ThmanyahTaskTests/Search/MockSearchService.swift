// 
//  MockSearchService.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
@testable import ThmanyahTask

final class MockSearchService: SearchServiceProtocol {
    let results: [SectionModel]?
    let error: Error?
    
    init(
        results: [SectionModel]? = nil,
        error: Error? = nil
    ) {
        self.results = results
        self.error = error
    }
    
    func search(query: String) async throws -> [SectionModel] {
        if let error { throw error }
        guard let results else {
            throw NSError(domain: "Mock", code: -1, userInfo: nil)
        }
        return results
    }
}
