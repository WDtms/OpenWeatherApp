//
//  AmodeusApiService.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation
import Alamofire

class AmodeusAPIService {
    static let shared: AmodeusAPIService = AmodeusAPIService()
    
    private let session: Session
    
    private init() {
        self.session = Session(interceptor: AmodeusAuthInterceptor())
    }
    
    func fetchCities(request: CitiesRequest, completion: @escaping (Result<CitiesResponse, Error>) -> Void) {
        let baseUrl = "https://test.api.amadeus.com/v1/reference-data/locations/cities"
        
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        session.request(url).validate(statusCode: 200..<300).responseDecodable(of: CitiesResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
