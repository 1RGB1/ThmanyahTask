// 
//  AsyncImageView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let placeholder: ImageResource = .placeholder
    
    var body: some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    Image(placeholder)
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.secondary)
                    
                default:
                    EmptyView()
                }
            }
        } else {
            Image(placeholder)
                .resizable()
                .scaledToFill()
                .foregroundStyle(.secondary)
        }
    }
}
