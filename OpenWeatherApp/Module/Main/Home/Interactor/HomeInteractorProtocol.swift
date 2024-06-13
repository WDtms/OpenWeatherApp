//
//  HomeInteractorProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import CoreLocation

protocol HomeInteractorProtocol: AnyObject {
    func checkLocationPermissions()
    
    func requestLocationPermissions()
    
    func requestUserLocation()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func handleLocationPermissionsGranted()
    
    func handleLocationPermissionsDenied()
    
    func handleFetchedLocation(with: CLLocation)
}
