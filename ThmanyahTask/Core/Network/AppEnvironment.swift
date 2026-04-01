//
//  AppEnvironment.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum AppEnvironment {
    static var homeBaseURL: String {
        ProcessInfo.processInfo.environment["HOME_BASE_URL"]
            ?? "https://api-v2-b2sit6oh3a-uc.a.run.app"
    }

    static var searchBaseURL: String {
        ProcessInfo.processInfo.environment["SEARCH_BASE_URL"]
            ?? "https://mock.apidog.com/m1/735111-711675-default"
    }
}
