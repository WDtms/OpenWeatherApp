//
//  SearchedCityViewController.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 13.06.2024.
//

import UIKit

class SearchedCityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchedCityViewController: WeatherDetailsViewProtocol {
    func showLoadingState() {
        <#code#>
    }
    
    func showFailedToLoadState() {
        <#code#>
    }
    
    func showLoadedState(currentWeatherDetails: CurrentWeatherDetails, weatherDateInfo: WeatherDateInfo) {
        <#code#>
    }
    
    func handleExpectedBadWeather(with: ExpectedBadWeatherViewModel) {
        <#code#>
    }
    
    
}
