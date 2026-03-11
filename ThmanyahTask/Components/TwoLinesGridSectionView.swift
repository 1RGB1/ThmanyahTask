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
    
    var body: some View {
        let rows = Array(repeating: GridItem(.flexible()), count: rowsCount)
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .top, spacing: 16) {
                    ForEach(Array(items.enumerated()), id: \.offset) {
                        TwoLinesGridView(
                            item: ContentItemDisplay.from($1),
                            containerWidth: proxy.size.width
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct TwoLinesGridView: View {
    let item: ContentItemDisplay
    let containerWidth: CGFloat
    let imageSize: CGFloat = 60
    var itemWidth: CGFloat { containerWidth * 0.85 }
    
    var body: some View {
        HStack(spacing: 8) {
            AsyncImageView(url: item.imageUrl)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                if let subtitle = item.subtitle, !subtitle.isEmpty {
                    Text(subtitle)
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
                
                Spacer()
                
                HStack {
                    if let duration = item.duration {
                        Text(duration)
                            .font(.thamanyahThin(10))
                            .foregroundStyle(Color.white)
                            .lineLimit(1)
                            .padding(5)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    
                    Image(systemName: "text.line.first.and.arrowtriangle.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.black)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: itemWidth, height: imageSize)
    }
}

#Preview {
    TwoLinesGridSectionView(
        items: Array(
            repeating:
                SectionContentItem.podcast(
                    PodcastContentModel(
                        podcastId: "1",
                        name: "مذكرات محقق حوادث طيران",
                        description: "أمس",
                        avatarUrl: "https://substackcdn.com/image/fetch/$s_!_DTC!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F24ed0475-37e1-4151-bc73-dfa2d882d260_2922x1558.png",
                        episodeCount: 1,
                        duration: 1350,
                        language: "ar",
                        priority: 1,
                        popularityScore: 150,
                        score: 150
                    )
                ),
            count: 9
        )
    )
    .frame(height: 136)
    .environment(\.layoutDirection, .rightToLeft)
}
