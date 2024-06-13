//
//  CurrentWeatherRequest.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

struct CurrentWeatherRequest {
    let longitude: Double
    let latitude: Double
    let appId: String
    
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "appid", value: appId)
        ]
    }
}
