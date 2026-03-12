// 
//  ContentView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Search", systemImage: "magnifyingglass") {
//                SearchView() // SwiftUI Solution
                SearchViewControllerRepresentable() // UIKit Solution
            }
        }
    }
}

#Preview {
    ContentView()
}
