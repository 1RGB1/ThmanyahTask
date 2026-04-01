//
//  Endpoints.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum Endpoints {
    static func homeSections(page: Int? = nil) -> Result<URL, Error> {
        var urlString = "\(AppEnvironment.homeBaseURL)/home_sections"
        if let page, page > 1 {
            urlString += "?page=\(page)"
        }

        guard let url = URL(string: urlString) else {
            return .failure(URLError(.badURL))
        }

        return .success(url)
    }

    static func search(query: String) -> Result<URL, Error> {
        guard var components = URLComponents(string: "\(AppEnvironment.searchBaseURL)/search") else {
            return .failure(URLError(.badURL))
        }

        components.queryItems = [URLQueryItem(name: "q", value: query)]

        guard let url = components.url else {
            return .failure(URLError(.badURL))
        }

        return .success(url)
    }
}
