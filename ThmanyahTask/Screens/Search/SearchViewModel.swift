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
    @Published private(set) var loadingState: LoadingState = .idle

    private let service: SearchServiceProtocol
    private var searchTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    private let debounceMS = 200

    init(service: SearchServiceProtocol = SearchService()) {
        self.service = service
        observeSearchText()
    }

    private func observeSearchText() {
        $searchText
            .debounce(for: .milliseconds(debounceMS), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }

                let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)

                guard !trimmed.isEmpty else {
                    self.sections.removeAll()
                    self.loadingState = .idle
                    return
                }

                self.searchTask?.cancel()
                self.searchTask = Task { [weak self] in
                    await self?.executeSearch(trimmed)
                }
            }
            .store(in: &cancellables)
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

    func retry() {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        searchTask?.cancel()
        searchTask = Task { [weak self] in
            await self?.executeSearch(trimmed)
        }
    }
}
