//
//  FeeLimitDataStore.swift
//  Currency Converter
//
//  Created by AndUser on 19/04/2023.
//

import Foundation
import RealmSwift

protocol FeeLimitDataStoreProtocol {
    func incrementTransactionCount()
    func getTransactionCount() -> Int
}

class FeeLimitDataStore: FeeLimitDataStoreProtocol {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
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
