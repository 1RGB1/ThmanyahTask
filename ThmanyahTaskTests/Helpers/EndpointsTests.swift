//
//  EndpointsTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

struct EndpointsTests {

    @Test func homeSectionsWithoutPageReturnsBaseURL() throws {
        let url = try Endpoints.homeSections().get()
        #expect(url.absoluteString.hasSuffix("/home_sections"))
        #expect(!url.absoluteString.contains("page="))
    }

    @Test func homeSectionsWithPage1ReturnsBaseURL() throws {
        let url = try Endpoints.homeSections(page: 1).get()
        #expect(!url.absoluteString.contains("page="))
    }

    @Test func homeSectionsWithPage2IncludesPageParam() throws {
        let url = try Endpoints.homeSections(page: 2).get()
        #expect(url.absoluteString.contains("page=2"))
    }

    @Test func searchBuildsURLWithQueryParam() throws {
        let url = try Endpoints.search(query: "test").get()
        #expect(url.absoluteString.contains("/search"))
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItem = components?.queryItems?.first(where: { $0.name == "q" })
        #expect(queryItem?.value == "test")
    }

    @Test func searchEncodesSpecialCharacters() throws {
        let url = try Endpoints.search(query: "hello world").get()
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItem = components?.queryItems?.first(where: { $0.name == "q" })
        #expect(queryItem?.value == "hello world")
    }

    @Test func searchEncodesArabicCharacters() throws {
        let url = try Endpoints.search(query: "بودكاست").get()
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItem = components?.queryItems?.first(where: { $0.name == "q" })
        #expect(queryItem?.value == "بودكاست")
    }
}
