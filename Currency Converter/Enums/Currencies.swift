//
//  Currencies.swift
//  Currency Converter
//
//  Created by AndUser on 03/04/2023.
//

import Foundation

enum Currencies: Int, CaseIterable {
    case EUR
    case USD
    case JPY

    var segmentIndex: Int {
        return rawValue
    }
    
    var segmentTitle: String {
        return String(describing: self)
    }
}
