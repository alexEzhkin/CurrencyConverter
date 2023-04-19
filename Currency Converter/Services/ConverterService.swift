//
//  ConverterService.swift
//  Currency Converter
//
//  Created by AndUser on 19/04/2023.
//

import Foundation

final class ConverterService {
    private let transactionService: TransactionServiceProtocol
    private let feeService: FeeServiceProtocol
    private let balanceDataService: BalanceDataStoreProtocol
    private let feeLimitDataService: FeeLimitDataStoreProtocol
    
    init(transactionService: TransactionServiceProtocol, feeService: FeeServiceProtocol, balanceDataService: BalanceDataStoreProtocol, feeLimitDataService: FeeLimitDataStoreProtocol) {
        self.transactionService = transactionService
        self.feeService = feeService
        self.balanceDataService = balanceDataService
        self.feeLimitDataService = feeLimitDataService
    }
    
    func calculateCommissionAmount(_ transaction: Transaction, isTransactionFree: Bool) -> Double {
        return transactionService.calculateCommissionAmount(transaction, isTransactionFree: isTransactionFree)
    }
    
    func checkFreeConversion(_ currenctConversionsNumber: Int) -> Bool {
        return feeService.checkFreeConversion(currenctConversionsNumber)
    }
    
    func getAllBalances() -> CurrencyRealmObject {
        return balanceDataService.getAllBalances()
    }
    
    func updateBalance(_ transaction: Transaction) {
        balanceDataService.updateBalance(transaction)
    }
    
    func incrementTransactionCount() {
        feeLimitDataService.incrementTransactionCount()
    }
    
    func getTransactionCount() -> Int {
        return feeLimitDataService.getTransactionCount()
    }
}
