//
//  HomePresenter.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import CoreLocation

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func configure(interactor: HomeInteractorProtocol, router: HomeRouterProtocol, view: HomeViewProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    func viewDidLoad() {
        view?.showLoadingState()
        
        interactor?.checkLocationPermissions()
    }
    
    func requestLocationPermissions() {
        interactor?.requestLocationPermissions()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func handleLocationPermissionsGranted() {
        interactor?.requestUserLocation()
    }
    
    func handleLocationPermissionsDenied() {
        view?.showUnknownLocationState()
    }
    
    func handleFetchedLocation(with location: CLLocation) {
        let childVC = WeatherDetailsRouter.createModule(
            with: Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
            showNavBar: false
        )
        
        view?.showLocationedState(childVC: childVC)
    }
}
