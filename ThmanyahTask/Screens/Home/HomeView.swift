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
                        .accessibilityIdentifier(AccessibilityIdentifiers.HomeIdentifiers.loadingView)
                    
                case .error(let message):
                    ErrorView(
                        message: message,
                        retry: {
                            Task { await viewModel.loadInitial() }
                        },
                        retryAccessibilityIdentifier: AccessibilityIdentifiers.HomeIdentifiers.retryButton
                    )
                    .accessibilityIdentifier(AccessibilityIdentifiers.HomeIdentifiers.errorView)
                    
                case .loaded, .loadingMore, .loadingEnded:
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
                                        .accessibilityIdentifier(AccessibilityIdentifiers.HomeIdentifiers.loadingMoreIndicator)
                                    Spacer()
                                }
                                .padding()
                            }
                            
                            if case .loadingEnded = viewModel.loadingState {
                                HStack {
                                    Spacer()
                                    Text("No more content")
                                        .font(.thamanyahRegular(12))
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                    }
                    .accessibilityIdentifier(AccessibilityIdentifiers.HomeIdentifiers.scrollView)
                }
            }
            .navigationTitle("Home")
            .task { await viewModel.loadInitial() }
        }
    }
}
