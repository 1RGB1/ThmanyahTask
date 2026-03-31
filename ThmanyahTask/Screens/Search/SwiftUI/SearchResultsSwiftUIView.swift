// 
//  SearchResultsSwiftUIView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct SearchResultsSwiftUIView: View {
    let sections: [SectionModel]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(Array(sections.enumerated()), id: \.offset) { _, section in
                    SectionView(section: section)
                }
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.SearchIdentifiers.resultsScrollView)
        .dismissKeyboardOnTap()
    }
}
