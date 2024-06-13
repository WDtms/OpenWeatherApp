//
//  SearchRouterProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

protocol SearchRouterProtocol {
    static func createModule() -> SearchViewProtocol
    
    func navigateToCityDetails(with: CityViewModel)
}
