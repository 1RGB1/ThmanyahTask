// 
//  HomeView.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ContentUnavailableView("Home", systemImage: "house.fill")
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
