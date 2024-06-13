//
//  WeatherDetailsRouter.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import UIKit

class WeatherDetailsRouter: WeatherDetailsRouterProtocol {
    weak var view: WeatherDetailsViewProtocol?
    
    static func createModule(with coordinates: Coordinates, showNavBar: Bool) -> any WeatherDetailsViewProtocol {
        let view = WeatherDetailsViewController()
        let presenter = WeatherDetailsPresenter()
        let interactor = WeatherDetailsInteractor()
        let router = WeatherDetailsRouter()
        
        view.configure(with: presenter, showNavBar: showNavBar)
        presenter.configure(interactor: interactor, view: view, router: router, coordinates: coordinates)
        interactor.configure(with: presenter)
        router.configure(with: view)
        
        return view
    }
    
    static func createSearchedModule(with city: CityViewModel) -> any WeatherDetailsViewProtocol {
        let view = SearchedCityViewController()
        let presenter = WeatherDetailsPresenter()
        let interactor = WeatherDetailsInteractor()
        let router = WeatherDetailsRouter()
        
        view.configure(with: presenter)
        presenter.configure(interactor: interactor, view: view, router: router, coordinates: Coordinates(latitude: city.latitude, longitude: city.longitude))
        interactor.configure(with: presenter)
        router.configure(with: view)
        
        return view
    }
    
    func configure(with view: WeatherDetailsViewProtocol) {
        self.view = view
    }
    
    func navigateToFullView(with coordinates: Coordinates) {
        let childVC = WeatherDetailsRouter.createModule(with: coordinates, showNavBar: true)
        
        let navController = UINavigationController(rootViewController: childVC)
        view?.navigationController?.present(navController, animated: true)
    }
}
