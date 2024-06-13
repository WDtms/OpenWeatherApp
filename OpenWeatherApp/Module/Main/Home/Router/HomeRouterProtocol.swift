//
//  HomeRouterProtocol.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    static func createModule() -> HomeViewProtocol
}
