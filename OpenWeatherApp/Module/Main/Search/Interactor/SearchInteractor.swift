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
        let request = CitiesRequest(expectedMaxCount: 40, keyword: name)
        
        AmodeusAPIService.shared.fetchCities(request: request) { [weak self] result in
            guard let self = self else { return }
            
            self.output?.handleFetch(with: result)
        }
    }
}
