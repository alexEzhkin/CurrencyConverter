//
//  FeeService.swift
//  Currency Converter
//
//  Created by AndUser on 18/04/2023.
//

import Foundation

protocol FeeServiceProtocol {
    func checkFreeConversion(_ currenctConversionsNumber: Int) -> Bool
}

class FeeService: FeeServiceProtocol {
    private let freeTransactionLimit: Int = 5
    
    func checkFreeConversion(_ currenctConversionsNumber: Int) -> Bool {
        
        if currenctConversionsNumber <= freeTransactionLimit {
            return true
        }
        
        return false
    }
}
