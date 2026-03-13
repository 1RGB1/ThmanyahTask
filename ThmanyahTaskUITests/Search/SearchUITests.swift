// 
//  SearchUITests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import XCTest

final class SearchUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    @MainActor
    func testSearchTabOpensSearch() throws {
        let searchTab = AppScreenHelpers.searchTab(in: app)
        XCTAssertTrue(searchTab.waitForExistence(timeout: 5))
        searchTab.tap()
        let searchField = AppScreenHelpers.searchTextField(in: app)
        XCTAssertTrue(searchField.waitForExistence(timeout: 3), "Search should have search bar with text field")
    }
    
    @MainActor
    func testHomeLoadsSections() throws {
        AppScreenHelpers.searchTab(in: app).tap()
        let emptyPrompt = AppScreenHelpers.searchEmptyPrompt(in: app)
        XCTAssertTrue(emptyPrompt.waitForExistence(timeout: 3), "Empty state 'Type here to search ...' should appear")
    }
    
    @MainActor
    func testSearchTypingShowsResultsOrNoResults() throws {
        AppScreenHelpers.searchTab(in: app).tap()
        let searchField = AppScreenHelpers.searchTextField(in: app)
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))
        searchField.tap()
        searchField.typeText("podcasts")
        let resultsScroll = AppScreenHelpers.searchResultsScrollView(in: app)
        let noResultsLabel = AppScreenHelpers.searchNoResults(in: app)
        let hasOutcome = resultsScroll.waitForExistence(timeout: 8) || noResultsLabel.waitForExistence(timeout: 8)
        XCTAssertTrue(hasOutcome, "Search should show either results or 'No results'")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
