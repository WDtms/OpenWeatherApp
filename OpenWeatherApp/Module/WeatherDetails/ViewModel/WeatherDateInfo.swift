//
//  DailtySunriseInfo.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 11.06.2024.
//

import Foundation

struct WeatherDateInfo {
    let sunriseDate: Date
    let sunsetDate: Date
    let currentDate: Date
    let daylightLength: DateComponents
    let remainingDaylight: DateComponents
    let timezone: Double
}
