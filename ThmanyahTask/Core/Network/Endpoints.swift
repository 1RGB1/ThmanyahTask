// 
//  Endpoints.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum Endpoints {
    static let baseHome = "https://api-v2-b2sit6oh3a-uc.a.run.app"
    static let baseSearch = "https://mock.apidog.com/m1/735111-711675-default"
    
    static func homeSections(page: Int? = nil) -> URL {
        var urlString = "\(baseHome)/home_sections"
        if let page, page > 1 {
            urlString += "?page=\(page)"
        }
        return URL(string: urlString)!
    }
    
    static func search(query: String) -> URL {
        var components = URLComponents(string: "\(baseSearch)/search")!
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        return components.url!
    }
}
