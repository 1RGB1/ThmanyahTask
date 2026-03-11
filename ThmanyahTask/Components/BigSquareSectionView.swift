// 
//  BigSquareSectionView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct BigSquareSectionView: View {
    let items: [SectionContentItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(Array(items.enumerated()), id: \.offset) {
                    BigSquareView(item: ContentItemDisplay.from($1))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BigSquareView: View {
    let item: ContentItemDisplay
    let imageSize: CGSize = CGSize(width: 250, height: 160)
    
    var body: some View {
        ZStack {
            AsyncImageView(url: item.imageUrl)
                .frame(width: imageSize.width, height: imageSize.height)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                
                Text(item.title)
                    .font(.thamanyahBold(10))
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let duration = item.duration {
                    Text(duration)
                        .font(.thamanyahThin(10))
                        .foregroundStyle(Color.white)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(width: imageSize.width, height: imageSize.height)
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    BigSquareSectionView(
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
    .environment(\.layoutDirection, .rightToLeft)
}
