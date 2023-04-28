//
//  TransactionRealmObject.swift
//  Currency Converter
//
//  Created by AndUser on 27/04/2023.
//

import Foundation
import RealmSwift

class TransactionRealmObject: Object {
    @objc dynamic var inputAmount: Double = 0
    @objc dynamic var inputCurrency: String = ""
    @objc dynamic var outputAmount: Double = 0
    @objc dynamic var outputCurrency: String = ""
    @objc dynamic var commission: Double = 0
    @objc dynamic var transactionStatus: Bool = false
    
}
