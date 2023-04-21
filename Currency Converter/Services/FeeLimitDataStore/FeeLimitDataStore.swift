//
//  FeeLimitDataStore.swift
//  Currency Converter
//
//  Created by AndUser on 19/04/2023.
//

import Foundation
import RealmSwift

protocol FeeLimitDataStoreProtocol {
    func setInitialFeeLimit()
    func incrementTransactionCount()
    func getTransactionCount() -> Int
}

class FeeLimitDataStore: FeeLimitDataStoreProtocol {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func setInitialFeeLimit() {
        if realm.objects(FeeLimitObject.self).count == 0 {
            // If the database does not exist, create a new FeeLimit object with default values and write it to the database
            let fee = FeeLimitObject()
            fee.freeTransactionLimit = 1
            
            try! realm.write {
                realm.add(fee)
            }
        }
    }
    
    func incrementTransactionCount() {
        let feeLimitObject = realm.objects(FeeLimitObject.self).first!
        try! realm.write {
            feeLimitObject.freeTransactionLimit += 1
        }
    }
    
    func getTransactionCount() -> Int {
        let feeLimitObject = realm.objects(FeeLimitObject.self).first!
        return feeLimitObject.freeTransactionLimit
    }
}
