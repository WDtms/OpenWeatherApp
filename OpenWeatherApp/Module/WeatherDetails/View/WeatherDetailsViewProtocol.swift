//
//  WeatherDetailsViewProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import UIKit

protocol WeatherDetailsViewProtocol: UIViewController { 
    func showLoadingState()
    
    func showFailedToLoadState()
    
    func showLoadedState(currentWeatherDetails: CurrentWeatherDetails, weatherDateInfo: WeatherDateInfo)
    
    func handleExpectedBadWeather(with: ExpectedBadWeatherViewModel)
}
