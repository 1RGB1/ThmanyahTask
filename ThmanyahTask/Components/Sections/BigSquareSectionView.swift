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
    let imageWidth: CGFloat = 250
    let imageHeight: CGFloat = 160
    
    var body: some View {
        ZStack {
            AsyncImageView(url: item.imageUrl)
                .frame(width: imageWidth, height: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                
                Text(item.title)
                    .font(.thamanyahBold(10))
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(width: imageWidth, height: imageHeight)
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
