//
//  ConversionAlertFactory.swift
//  Currency Converter
//
//  Created by AndUser on 25/04/2023.
//

import Foundation
import UIKit

class ConversionAlertFactory {
    static func showAlert(title: String? = nil, description: String? = nil) -> UIAlertController {
        let messageAlert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default)
        messageAlert.addAction(action)
        
        return messageAlert
    }
}
