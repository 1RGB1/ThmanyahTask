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
    
    static func homeSections(page: Int? = nil) -> Result<URL, Error> {
        var urlString = "\(baseHome)/home_sections"
        if let page, page > 1 {
            urlString += "?page=\(page)"
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(URLError(.badURL))
        }
        
        return .success(url)
    }
    
    static func search(query: String) -> Result<URL, Error> {
        guard var components = URLComponents(string: "\(baseSearch)/search") else {
            return .failure(URLError(.badURL))
        }
        
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = components.url else {
            return .failure(URLError(.badURL))
        }
        
        return .success(url)
    }
}
