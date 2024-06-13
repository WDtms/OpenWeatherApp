//
//  WeatherDetailsInteractor.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

class WeatherDetailsInteractor {
    weak var output: WeatherDetailsInteractorOutputProtocol?
    
    func configure(with output: WeatherDetailsInteractorOutputProtocol) {
        self.output = output
    }
}

extension WeatherDetailsInteractor: WeatherDetailsInteractorProtocol {
    func fetchTodayForecast(by coordinates: Coordinates) {
        guard let apiKey = getApiKey() else { return }
        let weatherRequest = CurrentWeatherRequest(longitude: coordinates.longitude, latitude: coordinates.latitude, appId: apiKey)
        
        WeatherAPIService.shared.fetchTodayForecast(for: weatherRequest) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let successModel):
                self.output?.handleFetchedForecast(with: successModel)
            case .failure(_):
                print("error occuired")
            }
        }
    }
    
    func fetchWeather(by coordinates: Coordinates) {
        guard let apiKey = getApiKey() else { return }
        let weatherRequest = CurrentWeatherRequest(longitude: coordinates.longitude, latitude: coordinates.latitude, appId: apiKey)
        
        WeatherAPIService.shared.fetchWeatherData(for: weatherRequest) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let successModel):
                self.output?.handleFetchedWeather(with: successModel)
            case .failure(_):
                self.output?.handleFailedToFetchWeather()
            }
        }
    }
    
    private func getApiKey() -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"), let config = NSDictionary(contentsOfFile: path) as? [String: AnyObject], let apiKey = config["API_KEY"] as? String else {
            return nil
        }
        
        return apiKey
    }
}
