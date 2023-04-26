//
//  BalanceDataStore.swift
//  Currency Converter
//
//  Created by AndUser on 18/04/2023.
//

import Foundation
import RealmSwift

protocol BalanceDataStoreProtocol {
    func setInitialBalance()
    func getAllBalances() -> CurrencyRealmObject
    func updateBalance(_ transaction: Transaction)
}

class BalanceDataStore: BalanceDataStoreProtocol {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func setInitialBalance() {
        if realm.objects(CurrencyRealmObject.self).count == 0 {
            // If the database does not exist, create a new Currency object with default values and write it to the database
            let currency = CurrencyRealmObject()
            currency.eur = 1000.00
            currency.usd = 0.00
            currency.jpy = 0.00
            
            try! realm.write {
                realm.add(currency)
            }
        }
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
