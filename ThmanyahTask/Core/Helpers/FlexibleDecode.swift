//
//  FlexibleDecode.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

enum FlexibleDecode {
    static func int<K: CodingKey>(from container: KeyedDecodingContainer<K>, forKey key: K) -> Int? {
        if let value = try? container.decode(Int.self, forKey: key) {
            return value
        }
        if let string = try? container.decode(String.self, forKey: key) {
            return Int(string)
        }
        return nil
    }

    static func double<K: CodingKey>(from container: KeyedDecodingContainer<K>, forKey key: K) -> Double? {
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let intValue = try? container.decode(Int.self, forKey: key) {
            return Double(intValue)
        }
        if let string = try? container.decode(String.self, forKey: key) {
            return Double(string)
        }
        return nil
    }
}
