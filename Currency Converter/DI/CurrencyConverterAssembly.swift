//
//  CurrencyConverterAssembly.swift
//  Currency Converter
//
//  Created by AndUser on 12/04/2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class CurrencyConverterAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
        container.register(CurrencyConverterPresenter.self) { r in
            return CurrencyConverterPresenter()
        }.inObjectScope(.container)
        
        container.register(CurrencyConverterInteractor.self) { r in
            return CurrencyConverterInteractor()
        }.inObjectScope(.container)
        
        container.register(CurrencyConverterRouter.self) { r in
            return CurrencyConverterRouter()
        }.inObjectScope(.container)
        
        container.autoregister(
            CurrencyConverterViewController.self, initializer: CurrencyConverterViewController.init
        ).inObjectScope(.transient)
    }
}

