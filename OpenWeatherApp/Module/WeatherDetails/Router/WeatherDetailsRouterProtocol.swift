//
//  WeatherDetailsRouterProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

protocol WeatherDetailsRouterProtocol: AnyObject {
    static func createModule(with: Coordinates, showNavBar: Bool) -> WeatherDetailsViewProtocol
    
    static func createSearchedModule(with: CityViewModel) -> WeatherDetailsViewProtocol
    
    func navigateToFullView(with: Coordinates)
}
