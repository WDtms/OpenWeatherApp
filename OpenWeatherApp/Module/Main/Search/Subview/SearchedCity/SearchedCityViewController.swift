//
//  SearchedCityViewController.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 13.06.2024.
//

import UIKit

class SearchedCityViewController: UIViewController {
    private var presenter: WeatherDetailsPresenterProtocol?
    private var loadedView: SearchedCityLoadedView?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        
        setupUI()
    }
    
    func configure(with presenter: WeatherDetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func setupUI() {
        view.backgroundColor    = .secondarySystemBackground
        view.layer.cornerRadius = 11
        
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        presenter?.navigateToFullView()
    }
}

extension SearchedCityViewController: WeatherDetailsViewProtocol {
    func showLoadingState() {
        
    }
    
    func showFailedToLoadState() {
        
    }
    
    func showLoadedState(currentWeatherDetails: CurrentWeatherDetails, weatherDateInfo: WeatherDateInfo) {
        if let loadedView = self.loadedView {
            loadedView.configure(details: currentWeatherDetails, weatherDateInfo: weatherDateInfo)
            
            return
        }
        
        let loadedView = SearchedCityLoadedView()
        self.loadedView = loadedView
        
        loadedView.configure(details: currentWeatherDetails, weatherDateInfo: weatherDateInfo)
        view.addSubview(loadedView)
        
        NSLayoutConstraint.activate([
            loadedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadedView.topAnchor.constraint(equalTo: view.topAnchor),
            loadedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func handleExpectedBadWeather(with expectedBadWeather: ExpectedBadWeatherViewModel) {
        if let loadedView = self.loadedView {
            loadedView.configure(expectedBadWeather: expectedBadWeather)
            
            return
        }
    }
}
