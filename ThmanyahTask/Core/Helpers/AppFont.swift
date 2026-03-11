// 
//  AppFont.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import SwiftUI
import UIKit

enum AppFont {
    enum Weight {
        case thin, extraLight, light, regular, medium, semibold, bold, text
    }
    
    private static let fontNames: [Weight : String] = [
        .thin: "IBMPlexSansArabic-Thin",
        .extraLight: "IBMPlexSansArabic-ExtraLight",
        .light: "IBMPlexSansArabic-Light",
        .regular: "IBMPlexSansArabic-Regular",
        .medium: "IBMPlexSansArabic-Medium",
        .semibold: "IBMPlexSansArabic-SemiBold",
        .bold: "IBMPlexSansArabic-Bold",
    ]
    
    static func font(weight: Weight, size: CGFloat) -> Font {
        return Font.custom(Self.fontName(for: weight), size: size)
    }
    
    static func font(weight: Weight, size: CGFloat) -> UIFont {
        let name = Self.fontName(for: weight)
        if let font = UIFont(name: name, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    private static func fontName(for weight: Weight) -> String {
        let name = Self.fontNames[weight] ?? "IBMPlexSansArabic-Regular"
        if weight == .regular, UIFont(name: name, size: 16) == nil {
            if let _ = UIFont(name: "IBMPlexSansArabic", size: 16) {
                return "IBMPlexSansArabic"
            }
        }
        return name
    }
}
