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
                .accessibilityIdentifier(AccessibilityIdentitiers.SearchIdentifiers.textField)
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
                    .accessibilityIdentifier(AccessibilityIdentitiers.SearchIdentifiers.loadingView)
            }
            
        case .loading:
            LoadingView()
                .accessibilityIdentifier(AccessibilityIdentitiers.SearchIdentifiers.loadingView)
            
        case .error(let message):
            ErrorView(
                message: message,
                retry: { viewModel.retry() },
                retryAccessibilityIdentifier: AccessibilityIdentitiers.SearchIdentifiers.retryButton
            )
            .accessibilityIdentifier(AccessibilityIdentitiers.SearchIdentifiers.errorView)
            
        case .loaded:
            if viewModel.sections.isEmpty {
                Text("No reasults")
                    .font(.thamanyahRegular(28))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .accessibilityIdentifier(AccessibilityIdentitiers.SearchIdentifiers.noResults)
            } else {
                SearchResultsSwiftUIView(sections: viewModel.sections)
            }
        }
    }
}
