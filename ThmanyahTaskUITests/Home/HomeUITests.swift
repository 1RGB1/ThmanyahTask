// 
//  HomeUITests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import XCTest

final class HomeUITests: XCTestCase {

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
    func testLaunchShowsHome() throws {
        let loadingExists = AppScreenHelpers.homeLoadingView(in: app).waitForExistence(timeout: 2)
        let scrollExists = AppScreenHelpers.homeScrollView(in: app).waitForExistence(timeout: 10)
        XCTAssertTrue(loadingExists || scrollExists, "Home should show loading or content")
    }

    @MainActor
    func testHomeLoadsSections() throws {
        let scrollView = AppScreenHelpers.homeScrollView(in: app)
        XCTAssertTrue(scrollView.waitForExistence(timeout: 15), "Home scroll view with sections should appear")
        
        let topPodcasts = AppScreenHelpers.sectionTitle(in: app, name: "Top Podcasts")
        let trending = AppScreenHelpers.sectionTitle(in: app, name: "Trending Episodes")
        let hasSection = topPodcasts.exists || trending.exists
        XCTAssertTrue(hasSection, "At least one secttion title should be visible")
    }
    
    @MainActor
    func testSwitchFromSearchBackToHome() throws {
        let searchTab = AppScreenHelpers.searchTab(in: app)
        XCTAssertTrue(searchTab.waitForExistence(timeout: 3), "Search tab should exist")
        searchTab.tap()
        
                XCTAssertTrue(AppScreenHelpers.searchTextField(in: app).waitForExistence(timeout: 5))
        AppScreenHelpers.homeTab(in: app).tap()
        let loadingExists = AppScreenHelpers.homeLoadingView(in: app).waitForExistence(timeout: 1)
        let scrollExists = AppScreenHelpers.homeScrollView(in: app).waitForExistence(timeout: 2)
        XCTAssertTrue(loadingExists || scrollExists, "Home should show after switching back")
    }
    
    @MainActor
    func testHomeScrollViewIsScrollableWhenLoaded() throws {
        let scrollView = AppScreenHelpers.homeScrollView(in: app)
        XCTAssertTrue(scrollView.waitForExistence(timeout: 15), "Home scroll view with sections should appear")
        scrollView.swipeUp()
        scrollView.swipeUp()
        XCTAssertTrue(scrollView.exists)
    }
    
    @MainActor
    func testSectionTitlesVisibleAfterLoad() throws {
        let scrollView = AppScreenHelpers.homeScrollView(in: app)
        XCTAssertTrue(scrollView.waitForExistence(timeout: 15), "Home scroll view with sections should appear")
        
        let section = AppScreenHelpers.sectionTitle(in: app, name: "Top Podcasts")
        XCTAssertTrue(section.exists, "Section 'Top Podcasts' should be visible")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
