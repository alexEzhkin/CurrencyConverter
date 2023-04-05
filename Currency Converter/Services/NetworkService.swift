//
//  NetworkService.swift
//  Currency Converter
//
//  Created by AndUser on 05/04/2023.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func createRequest(urlForRequest: String, method: HTTPMethod, parameters: [String: Any]?) -> URLRequest? {
        guard let url = URL(string: urlForRequest) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let params = parameters {
            if let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) {
                request.httpBody = httpBody
            }
        }
        return request
    }
    
    func getRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard error == nil else {
                    completion(.failure(.undentified))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.jsonSerilizationError))
                }
            }
        }.resume()
    }
}
