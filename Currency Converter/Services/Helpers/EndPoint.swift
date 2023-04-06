//
//  EndPoint.swift
//  Currency Converter
//
//  Created by AndUser on 05/04/2023.
//

import Foundation

protocol API {
    static var baseURL: String { get }
}

protocol RawRepresentable {
    associatedtype RawValue
    init?(rawValue: Self.RawValue)
    var route: Self.RawValue { get }
}

extension RawRepresentable where RawValue == String, Self: API {
    var url: String { Self.baseURL + route }
    
    init?(rawValue: String) { nil }
}

enum EndPoint: RawRepresentable, API {
    init?(rawValue: String) {
        nil
    }
    
    static let baseURL = "http://api.evp.lt"
    
    var route: String {
        switch self {
        case .exchange(let fromAmount, let fromCurrency, let toCurrency): return "/currency/commercial/exchange/\(fromAmount)-\(fromCurrency)/\(toCurrency)/latest"
        }
    }
    
    case exchange(fromAmount: Double, fromCurrency: String, toCurrency: String)
}
