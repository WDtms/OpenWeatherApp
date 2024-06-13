//
//  CitiesRequest.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

struct CitiesRequest {
    let expectedMaxCount: Int
    let keyword: String
    
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "max", value: String(expectedMaxCount)),
            URLQueryItem(name: "keyword", value: keyword)
        ]
    }
}
