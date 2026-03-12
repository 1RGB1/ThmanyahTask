// 
//  SearchViewControllerRepresentable.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI
import UIKit

struct SearchViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let searchViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
