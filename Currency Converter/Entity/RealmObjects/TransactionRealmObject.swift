//
//  TransactionRealmObject.swift
//  Currency Converter
//
//  Created by AndUser on 27/04/2023.
//

import Foundation
import RealmSwift

class TransactionRealmObject: Object {
    @Persisted var inputAmount: Double
    @Persisted var inputCurrency: String
    @Persisted var outputAmount: Double
    @Persisted var outputCurrency: String
    @Persisted var commission: Double
    @Persisted var transactionStatus: Bool
    @Persisted var transactionDate: Date
    
}
