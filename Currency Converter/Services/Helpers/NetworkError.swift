//
//  NetworkError.swift
//  Currency Converter
//
//  Created by AndUser on 05/04/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidResponse
    case jsonSerilizationError
    case undentified
}
