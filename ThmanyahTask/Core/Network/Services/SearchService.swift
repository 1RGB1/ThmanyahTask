// 
//  SearchServiceProtocol.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//


import Foundation

protocol SearchServiceProtocol: Sendable {
    func search(query: String) async throws -> [SectionModel]
}

final class SearchService: SearchServiceProtocol {
    private let client: APIClient
    
    nonisolated init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    func search(query: String) async throws -> [SectionModel] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else { return [] }
        
        let url = Endpoints.search(query: trimmed)
        let data: SearchResponse = try await client.fetch(from: url)
        let sortedSections = data.sections.sorted { $0.order < $1.order }
        return sortedSections
    }
}
