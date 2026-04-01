// 
//  QueueSectionView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//


import SwiftUI

struct QueueSectionView: View {
    let items: [SectionContentItem]
    var onPlayTapped: ((ContentItemDisplay) -> Void)?

    var body: some View {
        QueueView(items: items.map { ContentItemDisplay.from($0) }, onPlayTapped: onPlayTapped)
            .padding(.horizontal)
    }
}

struct QueueView: View {
    @Environment(\.layoutDirection) private var layoutDirection
    let items: [ContentItemDisplay]
    var onPlayTapped: ((ContentItemDisplay) -> Void)?
    let imageSize: CGFloat = 150
    @State private var currentIndex: Int = 0
    private var currentItem: ContentItemDisplay? {
        guard !items.isEmpty, currentIndex < items.count else { return nil }
        return items[currentIndex]
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                ForEach(Array(visibleItems.reversed()), id: \.offset) { index, item in
                    let offset = stackXOffset(for: index)
                    let scale = scaleEffect(for: index)
                    let zIndex = zIndex(for: index)
                    let opacity = opacity(for: index)

                    AsyncImageView(url: item.imageUrl)
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .scaleEffect(scale)
                        .offset(x: offset)
                        .opacity(opacity)
                        .zIndex(zIndex)
                        .gesture(
                            DragGesture(minimumDistance: 20)
                                .onEnded { handleSwipe($0) }
                        )
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: currentIndex)
                }
            }
            .frame(width: imageSize + 30, height: imageSize)
            .clipped()
            
            if let currentItem {
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    
                    Text(currentItem.title)
                        .font(.thamanyahBold(10))
                        .foregroundStyle(Color.white)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let subtitle = currentItem.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.thamanyahThin(10))
                            .foregroundStyle(Color.secondary)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: { onPlayTapped?(currentItem) }) {
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(Color.orange)
                                .padding(10)
                                .background(Color.white.opacity(0.15))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(.easeInOut(duration: 0.25), value: currentIndex)
                .id(currentIndex)
            }
        }
        .padding()
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var visibleItems: [(offset: Int, element: ContentItemDisplay)] {
        let lower = max(0, currentIndex - 2)
        let upper = min(items.count - 1, currentIndex + 2)
        guard lower <= upper else { return [] }
        return (lower...upper).map { (offset: $0, element: items[$0]) }
    }

    private func handleSwipe(_ value: DragGesture.Value) {
        let isRTL = layoutDirection == .rightToLeft
        let threshold: CGFloat = 20
        
        if value.translation.width < -threshold {
            advance(by: isRTL ? 1 : -1)
        } else if value.translation.width > threshold {
            advance(by: isRTL ? -1 : 1)
        }
    }
    
    private func advance(by step: Int) {
        let next = currentIndex + step
        guard next >= 0, next < items.count else { return }
        currentIndex = next
    }
    
    private func scaleEffect(for index: Int) -> CGFloat {
        let distance = abs(index - currentIndex)
        return max(1.0 - CGFloat(distance) * 0.05, 0.75)
    }
    
    private func stackXOffset(for index: Int) -> CGFloat {
        let distance = CGFloat(index - currentIndex)
        let direction: CGFloat = layoutDirection == .rightToLeft ? 1 : -1
        return distance * 18 * direction
    }
    
    private func zIndex(for index: Int) -> Double {
        return Double(items.count) - Double(abs(index - currentIndex))
    }
    
    private func opacity(for index: Int) -> Double {
        let distance = abs(index - currentIndex)
        switch distance {
        case 0: return 1.0
        case 1: return 0.7
        case 2: return 0.4
        default: return 0.0
        }
    }
}
