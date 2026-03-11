// 
//  SquareView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct SquareSectionView: View {
    let items: [SectionContentItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(Array(items.enumerated()), id: \.offset) {
                    SquareView(item: ContentItemDisplay.from($1))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SquareView: View {
    let item: ContentItemDisplay
    
    var body: some View {
        VStack(spacing: 8) {
            Image(.test)
                .resizable()
                .scaledToFill()
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.thamanyahBold(10))
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
                    
                    if let subtitle = item.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.thamanyahThin(10))
                            .foregroundStyle(Color.secondary)
                            .lineLimit(1)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: 100)
    }
}

#Preview {
    SquareSectionView(
        items: Array(
            repeating:
                SectionContentItem.podcast(
                    PodcastContentModel(
                        podcastId: "1",
                        name: "مذكرات محقق حوادث طيران",
                        description: "أمس",
                        avatarUrl: "https://www.thestreaminglab.com/p/thmanyah-review-the-new-home-of-saudi",
                        episodeCount: 1,
                        duration: 1350,
                        language: "ar",
                        priority: 1,
                        popularityScore: 150,
                        score: 150
                    )
                ),
            count: 8
        )
    )
    .environment(\.layoutDirection, .rightToLeft)
}
