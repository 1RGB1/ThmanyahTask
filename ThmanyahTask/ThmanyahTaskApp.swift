//
//  ThmanyahTaskApp.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

@main
struct ThmanyahTaskApp: App {
    init() {
        configureURLCache()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func configureURLCache() {
        URLCache.shared = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 100 * 1024 * 1024
        )
    }
}
