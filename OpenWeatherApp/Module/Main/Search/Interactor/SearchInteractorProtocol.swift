//
//  SearchInteractorProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject {
    func fetchCities(startsWith name: String)
    
    func fetchSearchedCities()
    
    func saveSearchedCity(city: CityViewModel)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func handleFetch(with result: Result<CitiesResponse, Error>)
    
    func handleSearchedCitiesFetch(cities: [CityViewModel])
}
