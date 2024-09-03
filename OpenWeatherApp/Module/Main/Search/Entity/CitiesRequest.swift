//
//  CitiesRequest.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

struct CitiesRequest {
    let name: String
    let limit: Int
    
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "limit", value: String(limit)),
        ]
    }
}
