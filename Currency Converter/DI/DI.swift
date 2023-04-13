//
//  DI.swift
//  Currency Converter
//
//  Created by AndUser on 12/04/2023.
//

import Foundation
import Swinject

class DI {
    private static let assemblies: [Assembly] = [
        CurrencyConverterAssembly()
    ]
    
    class func registerAppAssemblies() -> Assembler {
        return Assembler(assemblies)
    }
}
