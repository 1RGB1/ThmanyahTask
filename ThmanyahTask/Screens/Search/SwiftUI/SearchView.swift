// 
//  SearchView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.loadingState {
                case .idle:
                    if viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text("Type to search")
                            .font(.thamanyahRegular(32))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        LoadingView()
                    }
                    
                case .loading:
                    LoadingView()
                    
                case .error(let message):
                    ErrorView(
                        message: message,
                        retry: { viewModel.search() }
                    )
                    
                case .loaded:
                    if viewModel.sections.isEmpty {
                        Text("No reasults")
                            .font(.thamanyahRegular(15))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack(alignment: .leading, spacing: 24) {
                                ForEach(Array(viewModel.sections.enumerated()), id: \.offset) { _, section in
                                    SectionView(section: section)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .automatic,
            prompt: "Type here to search ..."
        )
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.search()
        }
    }
}
