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
        guard let sec = second, sec >= 0 else { return "00:00" }
        let hours = sec / 3600
        let minutes = (sec % 3600) / 60
        let seconds = sec % 60
        
        if hours > 0 {
            return String(format: "%dh %02dm %02ds", hours, minutes, seconds)
        }
        return String(format: "%02dm %02ds", minutes, seconds)
    }
}
