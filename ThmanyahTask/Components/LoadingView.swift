// 
//  LoadingView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

public struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    LinearGradient(
                        colors: [
                            .clear,
                            .white.opacity(0.4),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: proxy.size.width * 0.6)
                    .offset(x: -proxy.size.width * 0.6 + phase * proxy.size.width * 1.2)
                }
                    .mask(content)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

struct LoadingView: View {
    private let sectionsCount = 3
    private let cardsPerSection = 4
    private let cardSize: CGFloat = 140
    private let titleWidth: CGFloat = 120
    private let titleHeight: CGFloat = 20
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(0..<sectionsCount, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray5))
                            .frame(width: titleWidth, height: titleHeight)
                            .shimmer()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(0..<cardsPerSection, id: \.self) { _ in
                                    VStack(alignment: .leading, spacing: 8) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(.systemGray5))
                                            .frame(width: cardSize, height: cardSize)
                                            .shimmer()
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(.systemGray5))
                                            .frame(width: cardSize - 16, height: 14)
                                            .shimmer()
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(.systemGray5))
                                            .frame(width: cardSize * 0.5, height: 12)
                                            .shimmer()
                                    }
                                    .frame(width: cardSize)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .disabled(true)
                    }
                }
            }
            .padding(.vertical, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
