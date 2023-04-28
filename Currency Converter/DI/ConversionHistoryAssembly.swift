//
//  ConversionHistoryAssembly.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ConversionHistoryAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
        container.register(ConversionHistoryPresenter.self) { r in
            return ConversionHistoryPresenter()
        }.inObjectScope(.container)
        
        container.register(ConversionHistoryRouter.self) { r in
            return ConversionHistoryRouter()
        }.inObjectScope(.container)
        
        container.autoregister(ConverterService.self, initializer: ConverterService.init
        ).inObjectScope(.transient)
        
        container.autoregister(ConversionHistoryInteractor.self, initializer: ConversionHistoryInteractor.init
        ).inObjectScope(.transient)
        
        container.autoregister(CurrencyConverterInteractor.self, initializer: CurrencyConverterInteractor.init
        ).inObjectScope(.transient)
        
        container.autoregister(
            ConversionHistoryViewController.self, initializer: ConversionHistoryViewController.init
        ).inObjectScope(.transient)
    }
}
