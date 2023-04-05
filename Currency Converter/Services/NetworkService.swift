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
}
