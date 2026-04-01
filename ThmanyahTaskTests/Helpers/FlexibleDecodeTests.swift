//
//  FlexibleDecodeTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

struct FlexibleDecodeTests {

    private struct IntWrapper: Decodable {
        let value: Int?

        enum CodingKeys: String, CodingKey { case value }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            value = FlexibleDecode.int(from: container, forKey: .value)
        }
    }

    private struct DoubleWrapper: Decodable {
        let value: Double?

        enum CodingKeys: String, CodingKey { case value }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            value = FlexibleDecode.double(from: container, forKey: .value)
        }
    }

    @Test func intFromInt() throws {
        let json = Data(#"{"value": 42}"#.utf8)
        let result = try JSONDecoder().decode(IntWrapper.self, from: json)
        #expect(result.value == 42)
    }

    @Test func intFromString() throws {
        let json = Data(#"{"value": "42"}"#.utf8)
        let result = try JSONDecoder().decode(IntWrapper.self, from: json)
        #expect(result.value == 42)
    }

    @Test func intFromInvalidStringReturnsNil() throws {
        let json = Data(#"{"value": "abc"}"#.utf8)
        let result = try JSONDecoder().decode(IntWrapper.self, from: json)
        #expect(result.value == nil)
    }

    @Test func intFromNullReturnsNil() throws {
        let json = Data(#"{"value": null}"#.utf8)
        let result = try JSONDecoder().decode(IntWrapper.self, from: json)
        #expect(result.value == nil)
    }

    @Test func intFromMissingKeyReturnsNil() throws {
        let json = Data(#"{}"#.utf8)
        let result = try JSONDecoder().decode(IntWrapper.self, from: json)
        #expect(result.value == nil)
    }

    @Test func doubleFromDouble() throws {
        let json = Data(#"{"value": 3.14}"#.utf8)
        let result = try JSONDecoder().decode(DoubleWrapper.self, from: json)
        #expect(result.value == 3.14)
    }

    @Test func doubleFromInt() throws {
        let json = Data(#"{"value": 42}"#.utf8)
        let result = try JSONDecoder().decode(DoubleWrapper.self, from: json)
        #expect(result.value == 42.0)
    }

    @Test func doubleFromString() throws {
        let json = Data(#"{"value": "3.14"}"#.utf8)
        let result = try JSONDecoder().decode(DoubleWrapper.self, from: json)
        #expect(result.value == 3.14)
    }

    @Test func doubleFromInvalidStringReturnsNil() throws {
        let json = Data(#"{"value": "abc"}"#.utf8)
        let result = try JSONDecoder().decode(DoubleWrapper.self, from: json)
        #expect(result.value == nil)
    }

    @Test func doubleFromNullReturnsNil() throws {
        let json = Data(#"{"value": null}"#.utf8)
        let result = try JSONDecoder().decode(DoubleWrapper.self, from: json)
        #expect(result.value == nil)
    }
}
