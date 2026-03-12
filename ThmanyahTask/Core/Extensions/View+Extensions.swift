// 
//  View+Extensions.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI

public extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}
