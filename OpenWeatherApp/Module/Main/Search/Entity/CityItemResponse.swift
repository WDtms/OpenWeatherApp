//
//  CitiesResponse.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

struct CityItemResponse: Decodable {
    let name: String?
    let latitude: Double?
    let longitude: Double?
}
