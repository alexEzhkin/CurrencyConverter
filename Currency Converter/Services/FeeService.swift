//
//  FeeService.swift
//  Currency Converter
//
//  Created by AndUser on 18/04/2023.
//

import Foundation
import RealmSwift

protocol FeeServiceProtocol {
    func checkFreeConversion() -> Bool
    func incrementTransactionCount()
}

class FeeService: FeeServiceProtocol {
    private let freeTransactionLimit: Int = 5
    private let feeLimitFromRealm = try! Realm().objects(FeeLimitObject.self).first!
    
    func checkFreeConversion() -> Bool {
        let transactionCount = feeLimitFromRealm.freeTransactionLimit

        if transactionCount <= freeTransactionLimit {
            return true
        }
        return false
    }
    
    func incrementTransactionCount() {
        try! Realm().write({
            feeLimitFromRealm.freeTransactionLimit += 1
        })
    }
}
