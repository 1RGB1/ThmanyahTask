//
//  LoadingState.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum LoadingState: Equatable, Sendable {
    case idle
    case loading
    case loaded
    case loadingMore
    case error(String)
    case tryAgain
}
