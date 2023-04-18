//
//  TransactionService.swift
//  Currency Converter
//
//  Created by AndUser on 14/04/2023.
//

import Foundation

protocol TransactionServiceProtocol {
    func calculateCommissionAmount(_ transaction: Transaction, isTransactionFree: Bool) -> Double
}

class TransactionService: TransactionServiceProtocol {
    private let feeAmount: Double = 0.007
    
    func calculateCommissionAmount(_ transaction: Transaction, isTransactionFree: Bool) -> Double {
        if isTransactionFree {
            return 0.0
        } else {
            return transaction.inputAmount * feeAmount
        }
    }
}
