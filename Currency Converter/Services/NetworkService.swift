//
//  NetworkService.swift
//  Currency Converter
//
//  Created by AndUser on 05/04/2023.
//

import Foundation
import PromiseKit

final class NetworkService {
    func createRequest(urlForRequest: String, method: HTTPMethod, parameters: [String: Any]?) -> Promise<URLRequest> {
        return Promise { seal in
            guard let url = URL(string: urlForRequest) else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            if let params = parameters {
                if let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) {
                    request.httpBody = httpBody
                }
            }
            seal.fulfill(request)
        }
    }
    
    func getRequest<T: Decodable>(request: URLRequest) -> Promise<T> {
        return Promise { seal in
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                        seal.reject(NetworkError.invalidResponse)
                        return
                    }
                    
                    guard error == nil else {
                        seal.reject(NetworkError.undentified)
                        return
                    }
                    
                    guard let data = data else {
                        seal.reject(NetworkError.invalidData)
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        seal.fulfill(result)
                    } catch {
                        seal.reject(NetworkError.jsonSerilizationError)
                    }
                }
            }.resume()
        }
    }
}
