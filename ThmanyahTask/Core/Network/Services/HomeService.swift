// 
//  HomeService.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

protocol HomeServiceProtocol: Sendable {
    func fetchSections(page: Int) async throws -> (sections: [SectionModel], nextPage: Int?)
}

final class HomeService: HomeServiceProtocol {
    private let client: APIClient
    
    nonisolated init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    func fetchSections(page: Int) async throws -> (sections: [SectionModel], nextPage: Int?) {
        let result = Endpoints.homeSections(page: page == 1 ? nil : page)
        
        switch result {
        case .success(let url):
            let data: HomeModel = try await client.fetch(from: url)
            let sortedSections = data.sections.sorted { $0.order < $1.order }
            let nextPage: Int? = data.pagination?.nextPage.flatMap { path in
                URLComponents(string: "https://dumy\(path)")?.queryItems?.first(where: { $0.name == "page" })?.value.flatMap(Int.init)
            }
            return (sortedSections, nextPage)
            
        case .failure(let error):
            throw error
        }
        
    }
}
