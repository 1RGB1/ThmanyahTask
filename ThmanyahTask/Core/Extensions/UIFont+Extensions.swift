// 
//  UIFont+Extensions.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import UIKit

extension UIFont {
    static func thamanyahThin(_ size: CGFloat) -> UIFont { AppFont.font(weight: .thin, size: size) }
    static func thamanyahExtraLight(_ size: CGFloat) -> UIFont { AppFont.font(weight: .extraLight, size: size) }
    static func thamanyahLight(_ size: CGFloat) -> UIFont { AppFont.font(weight: .light, size: size) }
    static func thamanyahRegular(_ size: CGFloat) -> UIFont { AppFont.font(weight: .regular, size: size) }
    static func thamanyahMedium(_ size: CGFloat) -> UIFont { AppFont.font(weight: .medium, size: size) }
    static func thamanyahSemibold(_ size: CGFloat) -> UIFont { AppFont.font(weight: .semibold, size: size) }
    static func thamanyahBold(_ size: CGFloat) -> UIFont { AppFont.font(weight: .bold, size: size) }
    static func thamanyahText(_ size: CGFloat) -> UIFont { AppFont.font(weight: .text, size: size) }
}
