//
//  AmodeusApiService.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation
import Alamofire

class NinjasApiService {
    static let shared: NinjasApiService = NinjasApiService()
    
    private let session: Session
    
    private init() {
        self.session = Session()
    }
    
    func fetchCities(request: CitiesRequest, completion: @escaping (Result<[CityItemResponse], Error>) -> Void) {
        let baseUrl = "https://api.api-ninjas.com/v1/city"
        
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("TdLoFetFDFCm2CYMZiossw==XQ5QTkLaJmD5heEC", forHTTPHeaderField: "X-Api-Key")
        urlRequest.httpMethod = "GET"
        
        session.request(urlRequest).validate(statusCode: 200..<300).responseDecodable(of: [CityItemResponse].self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
