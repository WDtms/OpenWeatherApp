//
//  SearchViewController.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class SearchViewController: UIViewController {
    private var presenter: SearchPresenterProtocol?
    private var searchResultsController: InnerSearchViewController?
    
    private let searchHistoryStackView: UIStackView     = UIStackView()
    private let scrollView: UIScrollView                = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetchSavedSearchedCities()
        
        setupUI()
    }
    
    private func setupUI() {
        title = NSLocalizedString("search_tab_title", comment: "")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureSearchController()
        configureScrollView()
        configureSearchHistoryStackView()
    }
    
    private func configureSearchController() {
        searchResultsController             = InnerSearchViewController()
        searchResultsController?.delegate   = self
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater   = self
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = NSLocalizedString("search_bar_placeholder", comment: "")
        
        navigationItem.searchController = searchController
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints    = false
        scrollView.showsVerticalScrollIndicator                 = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureSearchHistoryStackView() {
        searchHistoryStackView.translatesAutoresizingMaskIntoConstraints    = false
        searchHistoryStackView.axis                                         = .vertical
        searchHistoryStackView.alignment                                    = .center
        searchHistoryStackView.spacing                                      = 40
        
        scrollView.addSubview(searchHistoryStackView)
        
        NSLayoutConstraint.activate([
            searchHistoryStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            searchHistoryStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            searchHistoryStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            searchHistoryStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            searchHistoryStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func addViewControllerToStackView(viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        searchHistoryStackView.addArrangedSubview(viewController.view)
        
        NSLayoutConstraint.activate([
            viewController.view.heightAnchor.constraint(equalToConstant: 176),
            viewController.view.leadingAnchor.constraint(equalTo: searchHistoryStackView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: searchHistoryStackView.trailingAnchor),
            viewController.view.widthAnchor.constraint(equalTo: searchHistoryStackView.widthAnchor),
        ])
    }
}

extension SearchViewController: SearchViewProtocol {
    func handleSearchedCitiesFetch(cities: [CityViewModel]) {
        for view in searchHistoryStackView.arrangedSubviews {
            searchHistoryStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for city in cities {
            let cityVC = WeatherDetailsRouter.createSearchedModule(with: city) as! SearchedCityViewController
            addChild(cityVC)
            
            addViewControllerToStackView(viewController: cityVC)
        
            cityVC.didMove(toParent: self)
        }
    }
    
    func configureWithPresenter(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func handleUpdatedSearchList(list: [CityViewModel]) {
        searchResultsController?.refreshSearchedList(with: list)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.fetchCities(startsWith: searchController.searchBar.text)
    }
}

extension SearchViewController: InnerSearchViewControllerDelegate {
    func handleTapped(on city: CityViewModel) {
        presenter?.handleTapped(on: city)
    }
}
