//
//  WeatherDetailsPresenterProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

protocol WeatherDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    func loadWeatherDetails(by: Coordinates)
    
    func navigateToFullView()
}
