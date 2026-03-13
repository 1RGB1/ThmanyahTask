// 
//  HomeView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.loadingState {
                case .idle, .loading:
                    LoadingView()
                        .accessibilityIdentifier(AccessibilityIdentitiers.HomeIdentifiers.loadingView)
                    
                case .error(let message):
                    ErrorView(
                        message: message,
                        retry: {
                            Task { await viewModel.loadInitial() }
                        },
                        retryAccessibilityIdentifier: AccessibilityIdentitiers.HomeIdentifiers.retryButton
                    )
                    .accessibilityIdentifier(AccessibilityIdentitiers.HomeIdentifiers.errorView)
                    
                case .loaded, .loadingMore:
                    ScrollView(showsIndicators: false) {
                        LazyVStack(alignment: .leading, spacing: 24) {
                            ForEach(Array(viewModel.sections.enumerated()), id: \.offset) { index, section in
                                SectionView(section: section)
                                    .onAppear {
                                        Task { await viewModel.loadNextPageIfNeeded(currentSectionIndex: index)
                                        }
                                    }
                            }
                            
                            if case .loadingMore = viewModel.loadingState {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .accessibilityIdentifier(AccessibilityIdentitiers.HomeIdentifiers.loadingMoreIndicator)
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                    }
                    .accessibilityIdentifier(AccessibilityIdentitiers.HomeIdentifiers.scrollView)
                }
            }
            .navigationTitle("Home")
            .task { await viewModel.loadInitial() }
        }
    }
}
