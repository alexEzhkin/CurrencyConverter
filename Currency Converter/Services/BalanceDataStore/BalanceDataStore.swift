//
//  BalanceDataStore.swift
//  Currency Converter
//
//  Created by AndUser on 18/04/2023.
//

import Foundation
import RealmSwift

protocol BalanceDataStoreProtocol {
    func getAllBalances() -> CurrencyRealmObject
    func updateBalance(_ transaction: Transaction)
}

class BalanceDataStore: BalanceDataStoreProtocol {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getAllBalances() -> CurrencyRealmObject {
        let currencyObject = realm.objects(CurrencyRealmObject.self).first!
        return currencyObject
    }
    
    func updateBalance(_ transaction: Transaction) {
        if let currencyObject = realm.objects(CurrencyRealmObject.self).first,
           let currentSellBalance = currencyObject.value(forKey: transaction.inputCurrency.lowercased()) as? Double,
           let currentReceiveBalance = currencyObject.value(forKey: transaction.outputCurrency.lowercased()) as? Double {
            
            let sellAmount = transaction.inputAmount + transaction.commission
            
            try! realm.write {
                currencyObject[transaction.inputCurrency.lowercased()] = (currentSellBalance - sellAmount).roundTo(places: 2)
                currencyObject[transaction.outputCurrency.lowercased()] = (currentReceiveBalance + transaction.outputAmount).roundTo(places: 2)
            }
        }
    }
}
