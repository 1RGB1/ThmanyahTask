// 
//  AccessibilityIdentifiers.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation

public enum AccessibilityIdentifiers {
    // MARK: - Home
    public enum HomeIdentifiers {
        public static let tap = "Home"
        public static let scrollView = "home_scroll_view"
        public static let loadingView = "home_loading_view"
        public static let errorView = "home_error_view"
        public static let retryButton = "home_retry_button"
        public static let loadingMoreIndicator = "home_loading_more"
    }
    
    // MARK: - Search
    public enum SearchIdentifiers {
        public static let tap = "Search"
        public static let textField = "search_text_field"
        public static let searchBar = "search_bar"
        public static let emptyPrompt = "search_empty_prompt"
        public static let resultsScrollView = "search_results_scroll_view"
        public static let noResults = "search_no_results"
        public static let loadingView = "search_loading_view"
        public static let errorView = "search_error_view"
        public static let retryButton = "search_retry_button"
    }
    
    // MARK: - Section (perfix + section name)
    public static func sectionTitle(_ name: String) -> String {
        "section_title_\(name.replacingOccurrences(of: " ", with: "_"))"
    }
    
    // MARK: - Shared
    public static let loadingIndicator = "loading_indicator"
    public static let errorMessage = "error_message"
}
