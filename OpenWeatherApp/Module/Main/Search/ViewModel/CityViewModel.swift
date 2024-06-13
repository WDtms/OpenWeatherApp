//
//  CityViewModel.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

struct CityViewModel: Hashable {
    let name: String
    let latitude: Double
    let longitude: Double
    
    static func ==(first: CityViewModel, second: CityViewModel) -> Bool {
        first.name == second.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
