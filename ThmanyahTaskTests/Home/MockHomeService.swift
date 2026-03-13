// 
//  HomeServiceProtocol.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
@testable import ThmanyahTask

final class MockHomeService: HomeServiceProtocol {
    let results: (sections: [SectionModel], nextPage: Int?)?
    let error: Error?
    
    init(
        results: (sections: [SectionModel], nextPage: Int?)? = nil,
        error: Error? = nil
    ) {
        self.results = results
        self.error = error
    }
    
    func fetchSections(page: Int) async throws -> (sections: [SectionModel], nextPage: Int?) {
        if let error { throw error }
        guard let results else {
            throw NSError(domain: "Mock", code: -1, userInfo: nil)
        }
        return results
    }
}
