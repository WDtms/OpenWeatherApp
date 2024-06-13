//
//  SearchPresenterProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func fetchCities(startsWith name: String?)
    
    func handleTapped(on: CityViewModel)
    
    func fetchSavedSearchedCities()
}
