//
//  HistoryDataStore.swift
//  Currency Converter
//
//  Created by AndUser on 27/04/2023.
//

import Foundation
import RealmSwift

protocol HistoryDataStoreProtocol {
    func setInitialHistory()
    func getTransactionHistory() -> [TransactionRealmObject]
    func updateTransactionHistory(_ transaction: Transaction, transactionStatus: Bool)
}

class HistoryDataStore: HistoryDataStoreProtocol {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func setInitialHistory() {
        if realm.objects(TransactionRealmObject.self).count == 0 {
            // If the database does not exist, create a new Transaction object with default values and write it to the database
            let transactionHistory = TransactionRealmObject()
            transactionHistory.inputAmount = 0
            transactionHistory.inputCurrency = ""
            transactionHistory.outputAmount = 0
            transactionHistory.outputCurrency = ""
            transactionHistory.transactionStatus = false
            
            try! realm.write {
                realm.add(transactionHistory)
            }
        }
    }
    
    func getTransactionHistory() -> [TransactionRealmObject] {
        let transactionObject = realm.objects(TransactionRealmObject.self)
        let transactionHistory = Array(transactionObject)
        
        return transactionHistory
    }
    
    func updateTransactionHistory(_ transaction: Transaction, transactionStatus: Bool) {
        try! realm.write {
            let newTransaction = TransactionRealmObject()
            
            newTransaction.inputAmount = transaction.inputAmount
            newTransaction.inputCurrency = transaction.inputCurrency
            newTransaction.outputAmount = transaction.outputAmount
            newTransaction.outputCurrency = transaction.outputCurrency
            newTransaction.commission = transaction.commission
            newTransaction.transactionStatus = transactionStatus
            
            realm.add(newTransaction)
        }
    }
    
}
