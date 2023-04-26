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
        
        container.register(ConversionHistoryInteractor.self) { r in
            return ConversionHistoryInteractor()
        }.inObjectScope(.container)
        
        container.autoregister(
            ConversionHistoryViewController.self, initializer: ConversionHistoryViewController.init
        ).inObjectScope(.transient)
    }
}
