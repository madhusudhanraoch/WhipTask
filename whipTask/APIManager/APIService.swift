//
//  APIService.swift
//  whipTask
//
//  Created by madhu sudhan on 21/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case jsonConversionFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

class APIService {
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, APIError>) -> ()) {
        
        guard let url = router.components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            if httpResponse.statusCode == 201 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let genericModel = try! decoder.decode(T.self, from: data)
                        completion(.success(genericModel))
                    } catch {
                        completion(.failure(.jsonConversionFailure))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        dataTask?.resume()
    }
}
