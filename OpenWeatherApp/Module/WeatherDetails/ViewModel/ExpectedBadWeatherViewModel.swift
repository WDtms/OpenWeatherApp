//
//  ExpectedBadWeatherViewModel.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

enum ExpectedBadWeatherViewModel {
    case rain(iconPath: String, Date)
    case snow(iconPath: String, Date)
    case none
}
