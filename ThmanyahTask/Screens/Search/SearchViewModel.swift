// 
//  SearchViewModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Combine
import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private(set) var sections: [SectionModel] = []
    @Published private(set) var loadingState: SearchLoadingState = .idle
    
    enum SearchLoadingState: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
    }
    
    private let service: SearchServiceProtocol
    private var searchTask: Task<Void, Never>?
    private let debounceMS: UInt64 = 200
    
    init(service: SearchServiceProtocol = SearchService()) {
        self.service = service
    }
    
    func search() {
        searchTask?.cancel()
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else {
            self.sections.removeAll()
            loadingState = .idle
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: .init(debounceMS * 1_000_000))
            guard !Task.isCancelled else { return }
            await executeSearch(query)
        }
    }
    
    private func executeSearch(_ query: String) async {
        loadingState = .loading
        do {
            let response = try await service.search(query: query)
            guard !Task.isCancelled else { return }
            sections = response
            loadingState = .loaded
        } catch {
            guard !Task.isCancelled else { return }
            loadingState = .error(error.localizedDescription)
        }
    }
}
