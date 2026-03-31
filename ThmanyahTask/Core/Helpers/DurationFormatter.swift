// 
//  DurationFormatter.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum DurationFormatter {
    static func format(second: Int?) -> String {
        guard let sec = second, sec >= 0 else { return "" }
        let hours = sec / 3600
        let minutes = (sec % 3600) / 60
        let seconds = sec % 60
        
        let hourString = hours > 0 ? "\(hours)h" : ""
        let minuteString = minutes > 0 ? " \(minutes)m" : ""
        let secondString = seconds > 0 ? " \(seconds)s" : ""
        return hourString + minuteString + secondString
    }
}
