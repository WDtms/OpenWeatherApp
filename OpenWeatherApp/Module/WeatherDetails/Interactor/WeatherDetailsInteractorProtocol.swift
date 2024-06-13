//
//  WeatherDetailsInteractorProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

protocol WeatherDetailsInteractorProtocol: AnyObject {
    func fetchWeather(by: Coordinates)
    
    func fetchTodayForecast(by: Coordinates)
}

protocol WeatherDetailsInteractorOutputProtocol: AnyObject {
    func handleFetchedWeather(with result: CurrentWeatherResponse)
    
    func handleFetchedForecast(with result: ForecastResponse)
    
    func handleFailedToFetchWeather()
}
