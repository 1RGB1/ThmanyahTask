// 
//  SearchViewController.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 13/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

final class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Type here to search ..."
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.accessibilityIdentifier = AccessibilityIdentifiers.SearchIdentifiers.textField
        search.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifiers.SearchIdentifiers.textField
        return search
    }()
    
    private let contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Type to search ..."
        label.textColor = .secondaryLabel
        label.font = .thamanyahRegular(28)
        label.accessibilityIdentifier = AccessibilityIdentifiers.SearchIdentifiers.emptyPrompt
        return label
    }()
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .thamanyahRegular(28)
        label.accessibilityIdentifier = AccessibilityIdentifiers.errorMessage
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        button.accessibilityIdentifier = AccessibilityIdentifiers.SearchIdentifiers.retryButton
        return button
    }()
    
    private var noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No results"
        label.textColor = .secondaryLabel
        label.font = .thamanyahRegular(28)
        label.accessibilityIdentifier = AccessibilityIdentifiers.SearchIdentifiers.noResults
        return label
    }()
    
    private var hostingController: UIHostingController<SearchResultsSwiftUIView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        setupContentContainer()
        setupSubviews()
        bindViewModel()
    }
    
    private func setupContentContainer() {
        view.addSubview(contentContainer)
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSubviews() {
        [emptyLabel, loadingIndicator, errorLabel, retryButton, noResultsLabel].forEach { contentContainer.addSubview($0) }
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 24),
            errorLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -24),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),

            noResultsLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateUI(for: state)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(for state: LoadingState) {
        emptyLabel.isHidden = true
        loadingIndicator.stopAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
        noResultsLabel.isHidden = true
        removeHostedResults()
        
        let query = viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch state {
        case .idle:
            if query.isEmpty {
                emptyLabel.isHidden = false
            } else {
                loadingIndicator.startAnimating()
            }
            
        case .loading:
            loadingIndicator.startAnimating()
            
        case .error(let message):
            errorLabel.text = message
            errorLabel.isHidden = false
            retryButton.isHidden = false
            
        case .loaded:
            if viewModel.sections.isEmpty {
                noResultsLabel.isHidden = false
            } else {
                embedResultsView(viewModel.sections)
            }

        case .loadingMore, .tryAgain:
            break
        }
    }
    
    private func removeHostedResults() {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
        hostingController = nil
    }
    
    private func embedResultsView(_ sections: [SectionModel]) {
        let resultsView = SearchResultsSwiftUIView(sections: sections)
        let hosting = UIHostingController(rootView: resultsView)
        hosting.view.backgroundColor = .clear
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hosting)
        contentContainer.addSubview(hosting.view)
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor)
        ])
        hosting.didMove(toParent: self)
        self.hostingController = hosting
    }
    
    @objc
    private func retryTapped() {
        viewModel.retry()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}
