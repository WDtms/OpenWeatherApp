//
//  HomeInteractor.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import CoreLocation

class HomeInteractor: NSObject, HomeInteractorProtocol {
    weak var output: HomeInteractorOutputProtocol?
    
    private var locationManager = CLLocationManager()
    
    func configure(with output: HomeInteractorOutputProtocol) {
        self.output = output
        locationManager.delegate = self
    }
    
    func checkLocationPermissions() {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            output?.handleLocationPermissionsDenied()
        case .authorizedAlways, .authorizedWhenInUse:
            output?.handleLocationPermissionsGranted()
        @unknown default:
            output?.handleLocationPermissionsDenied()
        }
    }
    
    func requestLocationPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestUserLocation() {
        locationManager.requestLocation()
    }
}

extension HomeInteractor: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermissions()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        
        output?.handleFetchedLocation(with: userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
