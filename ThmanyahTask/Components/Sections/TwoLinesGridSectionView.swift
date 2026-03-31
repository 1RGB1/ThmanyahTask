// 
//  TwoLinesGridSectionView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct TwoLinesGridSectionView: View {
    let items: [SectionContentItem]
    private let rowsCount: Int = 2
    private let itemHeight: CGFloat = 64
    private let spacing: CGFloat = 16
    private var totalHeight: CGFloat { (CGFloat(rowsCount) * itemHeight) + spacing }
    
    var body: some View {
        let rows = Array(repeating: GridItem(.flexible()), count: rowsCount)
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .top, spacing: spacing) {
                ForEach(Array(items.enumerated()), id: \.offset) {
                    TwoLinesGridView(item: ContentItemDisplay.from($1))
                }
            }
            .padding(.horizontal)
        }
        .frame(height: totalHeight)
    }
}

struct TwoLinesGridView: View {
    let item: ContentItemDisplay
    let imageSize: CGFloat = 64

    var body: some View {
        HStack(spacing: 8) {
            AsyncImageView(url: item.imageUrl)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                if let authorName = item.authorName, !authorName.isEmpty {
                    Text(authorName)
                        .font(.thamanyahThin(10))
                        .foregroundStyle(Color.secondary)
                        .lineLimit(1)
                }
                
                Text(item.title)
                    .font(.thamanyahBold(10))
                    .foregroundStyle(Color.primary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 8) {
                    if let duration = item.duration {
                        HStack(spacing: 4) {
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 5, height: 5)
                                .foregroundStyle(Color.orange)
                            
                            Text(duration)
                                .font(.thamanyahBold(8))
                                .foregroundStyle(Color.white)
                                .lineLimit(1)
                        }
                        .padding(5)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.orange)
                    
                    Image(systemName: "text.line.first.and.arrowtriangle.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.orange)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: imageSize)
        }
        .background(Color.clear)
        .frame(height: imageSize)
        .containerRelativeFrame(.horizontal) { width, _ in width * 0.85 }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
