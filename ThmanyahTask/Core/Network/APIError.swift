// 
//  APIError.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 12/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum APIError: Error, Sendable {
    case invalidURL
    case invalidResponse
    case unknownError
    case httpStatus(Int)
    case decoding(Error)
}
