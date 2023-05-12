//
//  DI.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Foundation
import Swinject

class DI {
    private var assembler: Assembler?
    
    static let shared = DI()
    
    private init() {}
    
    func registerAssemblies() {
        self.assembler = Assembler([
            CurrencyConverterAssembly(),
            ConversionHistoryAssembly(),
            HistoryDetailAssembly()
        ])
    }
    
    func resolve<T>(_ serviceType: T.Type) -> T? {
        return assembler?.resolver.resolve(serviceType)
    }
}
