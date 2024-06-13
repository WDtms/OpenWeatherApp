//
//  WeatherDetailsViewController.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    var presenter: WeatherDetailsPresenter?
    
    private var loadingView: WeatherDetailsLoadingView?
    private var loadedView: WeatherDetailsLoadedView?
    private var failedView: WeatherDetailsFailedToLoadView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
        setupUI()
    }
    
    func configure(with presenter: WeatherDetailsPresenter, showNavBar: Bool) {
        self.presenter = presenter
        
        setupDoneButton()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherDetailsViewController: WeatherDetailsViewProtocol {
    func handleExpectedBadWeather(with expectedBadWeatherViewModel: ExpectedBadWeatherViewModel) {
        guard let loadedView = self.loadedView else { return }
        
        loadedView.handleExpectedBadWeather(with: expectedBadWeatherViewModel)
    }
    
    func showLoadingState() {
        let loadingView = WeatherDetailsLoadingView()
        
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.loadingView = loadingView
    }
    
    func showFailedToLoadState() {
        hideLoadingView()
    }
    
    func showLoadedState(currentWeatherDetails: CurrentWeatherDetails, weatherDateInfo: WeatherDateInfo) {
        hideLoadingView()
        
        if let loadedView = self.loadedView {
            loadedView.configure(details: currentWeatherDetails, weatherDateInfo: weatherDateInfo)
            
            return
        }
        
        let loadedView = WeatherDetailsLoadedView()
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
    
    private func hideLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}
