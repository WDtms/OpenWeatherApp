//
//  WeatherResponse.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation


struct CurrentWeatherResponse: Decodable{
    let weather: [WeatherInfoResponse]
    let main: WeatherMainInfoResponse
    let wind: WeatherWindInfoResponse
    let sys: WeatherSunriseInfoResponse
    let visibility: Double
    let timezone: Double
    let name: String?
    
    struct WeatherInfoResponse: Decodable {
        let main: String
        let description: String
        let icon: String
    }
    
    struct WeatherMainInfoResponse: Decodable {
        let temp: Double
        let feelsLike: Double
        let pressure: Double
        let humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case humidity = "humidity"
            case pressure = "pressure"
            case feelsLike = "feels_like"
            case temp = "temp"
        }
    }
    
    struct WeatherSunriseInfoResponse: Decodable {
        let sunrise: Int
        let sunset: Int
    }
    
    struct WeatherWindInfoResponse: Decodable {
        let speed: Double
    }
}
