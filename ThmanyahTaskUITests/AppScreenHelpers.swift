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
        app.tabBars.buttons[AccessibilityIdentitiers.SearchIdentifiers.tap]
    }
    
    static func homeTab(in app: XCUIApplication) -> XCUIElement {
        app.tabBars.buttons[AccessibilityIdentitiers.HomeIdentifiers.tap]
    }
    
    static func homeScrollView(in app: XCUIApplication) -> XCUIElement {
        app.scrollViews[AccessibilityIdentitiers.HomeIdentifiers.scrollView]
    }
    
    static func homeLoadingView(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentitiers.HomeIdentifiers.loadingView]
    }
    
    static func homeErrorView(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentitiers.HomeIdentifiers.errorView]
    }
    
    static func homeRetryButton(in app: XCUIApplication) -> XCUIElement {
        app.buttons[AccessibilityIdentitiers.HomeIdentifiers.retryButton]
    }
    
    static func homeLoadingMoreIndicator(in app: XCUIApplication) -> XCUIElement {
        app.activityIndicators[AccessibilityIdentitiers.HomeIdentifiers.loadingMoreIndicator]
    }
    
    static func searchTextField(in app: XCUIApplication) -> XCUIElement {
        app.searchFields[AccessibilityIdentitiers.SearchIdentifiers.textField]
    }
    
    static func searchBar(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentitiers.SearchIdentifiers.searchBar]
    }
    
    static func searchEmptyPrompt(in app: XCUIApplication) -> XCUIElement {
        app.staticTexts[AccessibilityIdentitiers.SearchIdentifiers.emptyPrompt]
    }
    
    static func searchResultsScrollView(in app: XCUIApplication) -> XCUIElement {
        app.scrollViews[AccessibilityIdentitiers.SearchIdentifiers.resultsScrollView]
    }
    
    static func searchNoResults(in app: XCUIApplication) -> XCUIElement {
        app.staticTexts[AccessibilityIdentitiers.SearchIdentifiers.noResults]
    }
    
    static func searchLoadingView(in app: XCUIApplication) -> XCUIElement {
        app.otherElements[AccessibilityIdentitiers.SearchIdentifiers.loadingView]
    }
    
    static func sectionTitle(in app: XCUIApplication, name: String) -> XCUIElement {
        let id = AccessibilityIdentitiers.sectionTitle(name)
        return app.staticTexts[id]
    }
    
    static func wait(for element: XCUIElement, timeout: TimeInterval = 10) -> Bool {
        element.waitForExistence(timeout: timeout)
    }
}
