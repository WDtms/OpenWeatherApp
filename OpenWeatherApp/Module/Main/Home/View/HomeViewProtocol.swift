//
//  HomeViewProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import UIKit

protocol HomeViewProtocol: UIViewController {
    func showLoadingState()
    
    func showUnknownLocationState()
    
    func showLocationedState(childVC: WeatherDetailsViewProtocol)
}
