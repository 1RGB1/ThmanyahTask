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
                    
                case .error(let message):
                    ErrorView(message: message) {
                        Task { await viewModel.loadInitial() }
                    }
                    
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
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .task { await viewModel.loadInitial() }
        }
    }
}

#Preview {
    HomeView()
}
