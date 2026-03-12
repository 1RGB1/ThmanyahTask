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
    let imageSize: CGFloat = 140
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImageView(url: item.imageUrl)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.thamanyahBold(10))
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
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
        .frame(width: imageSize)
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
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
                        avatarUrl: "https://substackcdn.com/image/fetch/$s_!_DTC!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F24ed0475-37e1-4151-bc73-dfa2d882d260_2922x1558.png",
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
}
