//
//  WeatherApiService.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import Foundation

import Alamofire

class WeatherAPIService {
    static let shared = WeatherAPIService()
    
    private let session: Session
    
    private init() {
        self.session = Session()
    }
    
    func fetchWeatherData(for request: CurrentWeatherRequest, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void) {
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
        
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        session.request(url).validate(statusCode: 200..<300).responseDecodable(of: CurrentWeatherResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTodayForecast(for request: CurrentWeatherRequest, completion: @escaping (Result<ForecastResponse, Error>) -> Void) {
        let baseUrl = "https://api.openweathermap.org/data/2.5/forecast"
        
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        session.request(url).validate(statusCode: 200..<300).responseDecodable(of: ForecastResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
