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
    @State private var currentSectionIndex = 0
    
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
                    
                case .loaded, .loadingMore, .tryAgain:
                    ScrollView(showsIndicators: false) {
                        LazyVStack(alignment: .leading, spacing: 24) {
                            ForEach(Array(viewModel.sections.enumerated()), id: \.offset) { index, section in
                                SectionView(section: section)
                                    .onAppear {
                                        Task {
                                            currentSectionIndex = index
                                            await viewModel.loadNextPageIfNeeded(currentSectionIndex: index)
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
                            
                            if case .tryAgain = viewModel.loadingState {
                                HStack {
                                    Spacer()
                                    Text("Try Again")
                                        .font(.thamanyahRegular(12))
                                        .foregroundStyle(.secondary)
                                        .onTapGesture {
                                            Task {
                                                await viewModel.loadNextPageIfNeeded(currentSectionIndex: currentSectionIndex)
                                            }
                                        }
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
