//
//  MainTabBarController.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC      = HomeRouter.createModule()
        let searchVC    = SearchRouter.createModule()
        
        let homeNC      = UINavigationController(rootViewController: homeVC)
        let searchNC    = UINavigationController(rootViewController: searchVC)
        
        homeNC.tabBarItem.title     = NSLocalizedString("home_tab_title", comment: "")
        homeNC.tabBarItem.image     = UIImage(systemName: "house")
        
        searchNC.tabBarItem.title   = NSLocalizedString("search_tab_title", comment: "")
        searchNC.tabBarItem.image   = UIImage(systemName: "magnifyingglass")
        
        tabBar.tintColor                = .label
        tabBar.unselectedItemTintColor  = .secondaryLabel
        
        viewControllers = [homeNC, searchNC]
    }
}
