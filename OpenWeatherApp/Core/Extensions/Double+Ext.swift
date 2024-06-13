//
//  Double+Ext.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

extension Double {
    func fromKelvinToCelsius() -> Double {
        self - 273.15
    }
}
