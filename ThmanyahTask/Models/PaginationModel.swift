// 
//  PaginationModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

struct PaginationModel: Codable, Sendable {
    let nextPage: String?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
        case totalPages = "total_pages"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nextPage = try container.decodeIfPresent(String.self, forKey: .nextPage)
        
        if let int = try? container.decode(Int.self, forKey: .totalPages) {
            totalPages = int
        } else if let string = try? container.decode(String.self, forKey: .totalPages), let int = Int(string) {
            totalPages = int
        } else {
            totalPages = nil
        }
    }
}
