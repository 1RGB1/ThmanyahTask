// 
//  AppScreenHelpers.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import XCTest

enum AppScreenHelpers {
    static func searchTab(in app: XCUIApplication) -> XCUIElement {
        app.tabBars.buttons[AccessibilityIdentifiers.SearchIdentifiers.tap]
    }
    
    static func homeTab(in app: XCUIApplication) -> XCUIElement {
        app.tabBars.buttons[AccessibilityIdentifiers.HomeIdentifiers.tap]
    }
    
    static func homeScrollView(in app: XCUIApplication) -> XCUIElement {
        app.scrollViews[AccessibilityIdentifiers.HomeIdentifiers.scrollView]
    }
    
    static func homeLoadingView(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentifiers.HomeIdentifiers.loadingView]
    }
    
    static func homeErrorView(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentifiers.HomeIdentifiers.errorView]
    }
    
    static func homeRetryButton(in app: XCUIApplication) -> XCUIElement {
        app.buttons[AccessibilityIdentifiers.HomeIdentifiers.retryButton]
    }
    
    static func homeLoadingMoreIndicator(in app: XCUIApplication) -> XCUIElement {
        app.activityIndicators[AccessibilityIdentifiers.HomeIdentifiers.loadingMoreIndicator]
    }
    
    static func searchTextField(in app: XCUIApplication) -> XCUIElement {
        app.searchFields[AccessibilityIdentifiers.SearchIdentifiers.textField]
    }
    
    static func searchBar(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentifiers.SearchIdentifiers.searchBar]
    }
    
    static func searchEmptyPrompt(in app: XCUIApplication) -> XCUIElement {
        app.staticTexts[AccessibilityIdentifiers.SearchIdentifiers.emptyPrompt]
    }
    
    static func searchResultsScrollView(in app: XCUIApplication) -> XCUIElement {
        app.scrollViews[AccessibilityIdentifiers.SearchIdentifiers.resultsScrollView]
    }
    
    static func searchNoResults(in app: XCUIApplication) -> XCUIElement {
        app.staticTexts[AccessibilityIdentifiers.SearchIdentifiers.noResults]
    }
    
    static func searchLoadingView(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentifiers.SearchIdentifiers.loadingView]
    }
    
    static func sectionTitle(in app: XCUIApplication, name: String) -> XCUIElement {
        let id = AccessibilityIdentifiers.sectionTitle(name)
        return app.staticTexts[id]
    }
    
    static func wait(for element: XCUIElement, timeout: TimeInterval = 10) -> Bool {
        element.waitForExistence(timeout: timeout)
    }
}
