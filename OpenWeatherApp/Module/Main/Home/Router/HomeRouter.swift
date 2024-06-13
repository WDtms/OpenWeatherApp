//
//  HomeRouter.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

class HomeRouter: HomeRouterProtocol {
    weak var homeView: HomeViewProtocol?
    
    static func createModule() -> any HomeViewProtocol {
        let homeView    = HomeViewController()
        let interactor  = HomeInteractor()
        let presenter   = HomePresenter()
        let router      = HomeRouter()
        
        homeView.configure(with: presenter)
        presenter.configure(interactor: interactor, router: router, view: homeView)
        interactor.configure(with: presenter)
        router.configure(with: homeView)
        
        return homeView
    }
    
    private func configure(with homeView: HomeViewProtocol) {
        self.homeView = homeView
    }
}
