//
//  Double + Extension.swift
//  Currency Converter
//
//  Created by AndUser on 14/04/2023.
//

import Foundation

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
