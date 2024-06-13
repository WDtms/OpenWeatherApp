//
//  SearchRouter.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation
import UIKit

class SearchRouter: SearchRouterProtocol {
    weak var homeView: SearchViewController?
    
    static func createModule() -> SearchViewProtocol {
        let view = SearchViewController()
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        presenter.configure(interactor: interactor, view: view, router: router)
        interactor.configure(output: presenter)
        view.configureWithPresenter(presenter: presenter)
        router.configure(view: view)
        
        return view
    }
    
    func configure(view: SearchViewController) {
        homeView = view
    }
    
    func navigateToCityDetails(with city: CityViewModel) {
        let childVC = WeatherDetailsRouter.createModule(with: Coordinates(latitude: city.latitude, longitude: city.longitude), showNavBar: true)
        
        let navController = UINavigationController(rootViewController: childVC)
        homeView?.navigationController?.present(navController, animated: true)
    }
}
