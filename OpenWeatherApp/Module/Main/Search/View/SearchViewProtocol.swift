//
//  File.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import UIKit

protocol SearchViewProtocol: UIViewController {
    func handleUpdatedSearchList(list: [CityViewModel])
    
    func handleSearchedCitiesFetch(cities: [CityViewModel])
}
