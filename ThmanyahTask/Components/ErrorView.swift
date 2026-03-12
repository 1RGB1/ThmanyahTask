// 
//  ErrorView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retry: (() -> Void)?
    
    init(
        message: String,
        retry: (() -> Void)? = nil
    ) {
        self.message = message
        self.retry = retry
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.octagon")
                .font(.thamanyahBold(34))
                .foregroundStyle(.secondary)
                
            Text(message)
                .font(.thamanyahRegular(15))
                .foregroundColor(.secondary)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let retry = retry {
                Button(action: retry) {
                    Text("Retry")
                        .font(.thamanyahRegular(15))
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
