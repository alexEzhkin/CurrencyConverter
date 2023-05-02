//
//  HistoryDataStore.swift
//  Currency Converter
//
//  Created by AndUser on 27/04/2023.
//

import Foundation
import RealmSwift

protocol HistoryDataStoreProtocol {
    func getTransactionHistory() -> [TransactionRealmObject]
    func updateTransactionHistory(_ transaction: Transaction, transactionStatus: Bool)
}

class HistoryDataStore: HistoryDataStoreProtocol {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getTransactionHistory() -> [TransactionRealmObject] {
        let transactionObject = realm.objects(TransactionRealmObject.self).sorted(
            byKeyPath: "transactionDate",
            ascending: false
        )
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
            newTransaction.transactionDate = Date()
            
            realm.add(newTransaction)
        }
    }
    
}
