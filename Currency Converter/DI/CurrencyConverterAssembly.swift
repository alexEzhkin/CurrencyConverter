//
//  CurrencyConverterAssembly.swift
//  Currency Converter
//
//  Created by AndUser on 12/04/2023.
//

import Foundation
import Swinject

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
        
        container.register(CurrencyConverterViewController.self) { r in
            let presenter = r.resolve(CurrencyConverterPresenter.self)!
            let interactor = r.resolve(CurrencyConverterInteractor.self)!
            let router = r.resolve(CurrencyConverterRouter.self)!
            let viewController = CurrencyConverterViewController(interactor: interactor, presenter: presenter)
            
            return viewController
        }.inObjectScope(.weak)
    }
}

