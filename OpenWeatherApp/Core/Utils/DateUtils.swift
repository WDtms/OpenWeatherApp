//
//  DateUtils.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 11.06.2024.
//

import Foundation

enum DateUtils {
    static func getHHMMformattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: date)
    }
}
