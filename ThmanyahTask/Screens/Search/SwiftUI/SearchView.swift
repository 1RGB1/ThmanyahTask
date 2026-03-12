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
                searchBar
                content
            }
            .navigationTitle("Search")
            .dismissKeyboardOnTap()
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField("Type here to search ...", text: $viewModel.searchText)
                .textFieldStyle(.plain)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.loadingState {
        case .idle:
            if viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("Type to search")
                    .font(.thamanyahRegular(28))
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
                retry: { viewModel.retry() }
            )
            
        case .loaded:
            if viewModel.sections.isEmpty {
                Text("No reasults")
                    .font(.thamanyahRegular(28))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                SearchResultsSwiftUIView(sections: viewModel.sections)
            }
        }
    }
}
