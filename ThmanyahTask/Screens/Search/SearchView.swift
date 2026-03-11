// 
//  SearchView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ContentUnavailableView("Search Tab", systemImage: "magnifyingglass")
            }
            .navigationTitle("Search")
        }
        .searchable(
            text: $searchText,
            placement: .automatic,
            prompt: "type here to search"
        )
    }
}

#Preview {
    SearchView(searchText: "Type something to search ...")
}
