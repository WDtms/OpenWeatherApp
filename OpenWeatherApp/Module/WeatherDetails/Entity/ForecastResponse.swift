//
//  ForecastResponse.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

struct ForecastResponse: Codable {
    let list: [Forecast]
    
    struct Forecast: Codable {
        let dt: Int
        let weather: [Weather]
        
        struct Weather: Codable {
            let main: String
        }
    }
}
