// 
//  SectionView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct SectionView: View {
    let section: SectionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(section.name ?? "")
                .font(.thamanyahBold(32))
                .padding(.horizontal)
            
            switch section.layoutType {
            case .square:
                SquareSectionView(items: section.items)
                
            case .twoLinesGrid:
                TwoLinesGridSectionView(items: section.items)
                
            case .bigSquare:
                BigSquareSectionView(items: section.items)
                
            case .queue:
                QueueSectionView(items: section.items)
            }
        }
        .padding(.vertical, 8)
    }
}
