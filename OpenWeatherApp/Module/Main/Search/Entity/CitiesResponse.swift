//
//  CitiesResponse.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

struct CitiesResponse: Decodable {
    let data: [CityItemResponse]?
    
    struct CityItemResponse: Decodable {
        let name: String?
        let subType: String?
        let geoCode: CityGeoResponse?
        
        struct CityGeoResponse: Decodable {
            let latitude: Double?
            let longitude: Double?
        }
    }
}
