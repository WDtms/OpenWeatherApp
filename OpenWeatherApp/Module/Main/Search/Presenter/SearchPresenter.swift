//
//  SearchPresenter.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation

class SearchPresenter {
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    var currentName: String?
    var searchedCityList: [CityViewModel] = []
    
    func configure(interactor: any SearchInteractorProtocol, view: any SearchViewProtocol, router: any SearchRouterProtocol) {
        self.interactor = interactor
        self.view       = view
        self.router     = router
    }
    
    private func filterList(list: [CityViewModel], by startsWith: String) -> [CityViewModel] {
        let listToEmit = list.filter { city in
            city.name.lowercased().hasPrefix(startsWith.lowercased())
        }
        
        return listToEmit
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func fetchSavedSearchedCities() {
        interactor?.fetchSearchedCities()
    }
    
    func handleTapped(on city: CityViewModel) {
        interactor?.saveSearchedCity(city: city)
        
        fetchSavedSearchedCities()
        
        router?.navigateToCityDetails(with: city)
    }
    
    func fetchCities(startsWith name: String?) {
        currentName = name
        
        guard let name = name, !name.isEmpty, name.count >= 3 else {
            searchedCityList = []
            view?.handleUpdatedSearchList(list: searchedCityList)
            
            return
        }
        
        view?.handleUpdatedSearchList(list: filterList(list: searchedCityList, by: name))
        interactor?.fetchCities(startsWith: name)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func handleSearchedCitiesFetch(cities: [CityViewModel]) {
        view?.handleSearchedCitiesFetch(cities: cities)
    }
    
    func handleFetch(with result: Result<CitiesResponse, any Error>) {
        switch result {
        case .success(let success):
            let newCityList: [CityViewModel] = success.data?.compactMap { item in
                guard let cityName = item.name, let latitude = item.geoCode?.latitude, let longitude = item.geoCode?.longitude, item.subType == "city" else {
                    return nil
                }
                
                return CityViewModel(name: cityName, latitude: latitude, longitude: longitude)
            } ?? []
            
            guard let startsWith = currentName?.lowercased() else { return }
            
            let newListWithoudDuplicates = Array(Set(newCityList))
            
            var listToEmit = filterList(list: searchedCityList, by: startsWith).filter { oldCity in
                newListWithoudDuplicates.contains(oldCity)
            }
            let newItemsToAdd = filterList(list: newListWithoudDuplicates, by: startsWith).filter { newCity in
                !listToEmit.contains(newCity)
            }
            
            listToEmit.append(contentsOf: newItemsToAdd)
            
            searchedCityList = listToEmit
            view?.handleUpdatedSearchList(list: listToEmit)
        case .failure(_):
            #warning("Add logging and error handling")
            print("error")
        }
    }
}
