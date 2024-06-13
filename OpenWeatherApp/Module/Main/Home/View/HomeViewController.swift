//
//  HomeViewController.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    
    var unknownLocationStateView: HomeUnknownLocationStateView?
    var loadingStateView: HomeLoadingStateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configure(with presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension HomeViewController: HomeViewProtocol {
    func showUnknownLocationState() {
        removeLoadingState()
        
        let unknownLocationStateView        = HomeUnknownLocationStateView()
        unknownLocationStateView.delegate   = self
        
        view.addSubview(unknownLocationStateView)
        
        NSLayoutConstraint.activate([
            unknownLocationStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            unknownLocationStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            unknownLocationStateView.topAnchor.constraint(equalTo: view.topAnchor),
            unknownLocationStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.unknownLocationStateView = unknownLocationStateView
    }
    
    func showLoadingState() {
        let loadingStateView = HomeLoadingStateView()
        
        view.addSubview(loadingStateView)
        
        NSLayoutConstraint.activate([
            loadingStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingStateView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.loadingStateView = loadingStateView
    }
    
    func showLocationedState(childVC: WeatherDetailsViewProtocol) {
        removeLoadingState()
        
        addChild(childVC)
        
        childVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height)
        
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    private func removeLoadingState() {
        self.loadingStateView?.removeFromSuperview()
        self.loadingStateView = nil
    }
}

extension HomeViewController: HomeUnknownLocationStateDelegate {
    func requestLocationPermission() {
        presenter?.requestLocationPermissions()
    }
}
