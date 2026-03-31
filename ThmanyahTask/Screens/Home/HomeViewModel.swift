// 
//  HomeViewModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var loadingState: LoadingState = .idle
    @Published private(set) var sections: [SectionModel] = []
    @Published private(set) var nextPage: Int?
    
    enum LoadingState: Equatable {
        case idle
        case loading
        case loaded
        case loadingMore
        case error(String)
        case loadingEnded
    }
    
    private let service: HomeServiceProtocol
    private var currentPage = 1
    
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    func loadInitial() async {
        guard loadingState != .loading else { return }
        
        loadingState = .loading
        sections = []
        currentPage = 1
        
        await fetchPage(1)
    }
    
    func loadNextPageIfNeeded(currentSectionIndex: Int) async {
        guard case .loaded = loadingState,
              let nextPage,
              currentSectionIndex >= sections.count - 2
        else { return }
        
        loadingState = .loadingMore
        
        await fetchPage(nextPage)
    }
    
    private func fetchPage(_ page: Int) async {
        if loadingState != .loadingEnded {
            do {
                let (newSections, next) = try await service.fetchSections(page: page)
                if page == 1 {
                    sections = newSections
                } else {
                    sections.append(contentsOf: newSections)
                }
                loadingState = .loaded
                nextPage = next
                currentPage = page
            } catch {
                if page == 1 {
                    loadingState = .error(error.localizedDescription)
                } else {
                    loadingState = .loadingEnded
                }
            }
        }
    }
}
