//
//  SearchInteractor.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

class SearchInteractor: SearchInteractorProtocol {
    weak var output: SearchInteractorOutputProtocol?
    
    func configure(output: any SearchInteractorOutputProtocol) {
        self.output = output
    }
    
    func fetchCities(startsWith name: String) {
        let request = CitiesRequest(name: name, limit: 40)
        
        NinjasApiService.shared.fetchCities(request: request) { [weak self] result in
            guard let self = self else { return }
            
            self.output?.handleFetch(with: result)
        }
    }
    
    func fetchSearchedCities() {
        let locations = CoreDataManager.shared.fetchLastSearchedLocations()
        
        output?.handleSearchedCitiesFetch(cities: locations)
    }
    
    func saveSearchedCity(city: CityViewModel) {
        CoreDataManager.shared.addNewLocation(newLoc: city)
    }
}
