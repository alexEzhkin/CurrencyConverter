//
//  FeeLimitObject.swift
//  Currency Converter
//
//  Created by AndUser on 14/04/2023.
//

import Foundation
import RealmSwift

class FeeLimitObject: Object {
    @objc dynamic var freeTransactionLimit: Int = 0
    
}
