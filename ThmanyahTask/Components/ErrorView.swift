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
    let retryAccessibilityIdentifier: String
    
    init(
        message: String,
        retry: (() -> Void)? = nil,
        retryAccessibilityIdentifier: String
    ) {
        self.message = message
        self.retry = retry
        self.retryAccessibilityIdentifier = retryAccessibilityIdentifier
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
                .accessibilityIdentifier(AccessibilityIdentifiers.errorMessage)
            
            if let retry = retry {
                Button(action: retry) {
                    Text("Retry")
                        .font(.thamanyahRegular(15))
                }
                .buttonStyle(.borderedProminent)
                .accessibilityIdentifier(retryAccessibilityIdentifier)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
