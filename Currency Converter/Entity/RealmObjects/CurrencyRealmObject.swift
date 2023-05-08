//
//  CurrencyRealmObject.swift
//  Currency Converter
//
//  Created by AndUser on 08/04/2023.
//

import Foundation
import RealmSwift

class CurrencyRealmObject: Object {
    @objc dynamic var eur: Double = 0.00
    @objc dynamic var usd: Double = 0.00
    @objc dynamic var jpy: Double = 0.00
    
    func toDictionary() -> [String: Double] {
        return [
            Currencies.EUR.segmentTitle: eur,
            Currencies.USD.segmentTitle: usd,
            Currencies.JPY.segmentTitle: jpy
        ]
    }
}
