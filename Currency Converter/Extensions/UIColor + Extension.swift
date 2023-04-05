//
//  UIColor + Extension.swift
//  Currency Converter
//
//  Created by AndUser on 04/04/2023.
//

import UIKit

extension UIColor {
    static let customBlueColor = UIColor.color(named: "customBlueColor")
    
    private static func color(named: String) -> UIColor {
        return UIColor(named: named) ?? .clear
    }
}

