//
//  AmodeusAuthInterceptor.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import Foundation
import Alamofire

class AmodeusAuthInterceptor: RequestInterceptor {
    private let queue = DispatchQueue(label: "com.amodeus.auth.interceptor")
    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    private var tokenRefreshCompletions: [(Result<String, Error>) -> Void] = []

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        queue.async {
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
                completion(.doNotRetryWithError(error))
                return
            }
            
            self.requestsToRetry.append(completion)
            
            if self.requestsToRetry.count == 1 {
                // Ensure that only the first failed request triggers the token refresh.
                self.refreshTokens { result in
                    self.queue.async {
                        switch result {
                        case .success:
                            self.requestsToRetry.forEach { retryCompletion in
                                retryCompletion(.retry)
                            }
                        case .failure(let error):
                            self.requestsToRetry.forEach { retryCompletion in
                                retryCompletion(.doNotRetryWithError(error))
                            }
                        }
                        self.requestsToRetry.removeAll()
                    }
                }
            }
        }
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        getAccessToken { result in
            switch result {
            case .success(let accessToken):
                var urlRequest = urlRequest
                urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                completion(.success(urlRequest))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getAccessToken(completion: @escaping (Result<String, any Error>) -> Void) {
        if let savedAccessToken = SecureStorage.getAccessToken() {
            completion(.success(savedAccessToken))
            return
        }
        
        refreshTokens { result in
            completion(result)
        }
    }
    
    private func refreshTokens(completion: @escaping (Result<String, Error>) -> Void) {
        queue.async {
            self.tokenRefreshCompletions.append(completion)
            
            if self.isRefreshing {
                return
            }
            
            self.isRefreshing = true
            
            let url = "https://test.api.amadeus.com/v1/security/oauth2/token"
            let parameters: [String: String] = [
                "grant_type": "client_credentials",
                "client_id": "19PpkA76tEYuSMmOoZPAWEnBpnpxSA0j",
                "client_secret": "7qYguiRv7nYx8z1z"
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
                self.queue.async {
                    self.isRefreshing = false
                    
                    switch response.result {
                    case .success(let tokenResponse):
                        SecureStorage.saveAccessToken(with: tokenResponse.accessToken)
                        self.tokenRefreshCompletions.forEach { $0(.success(tokenResponse.accessToken)) }
                    case .failure(let error):
                        self.tokenRefreshCompletions.forEach { $0(.failure(error)) }
                    }
                    
                    self.tokenRefreshCompletions.removeAll()
                }
            }
        }
    }
}

