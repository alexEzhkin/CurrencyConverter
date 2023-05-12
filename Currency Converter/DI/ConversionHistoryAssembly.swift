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
        
        container.register(HistoryDataStoreProtocol.self) { r in
            return HistoryDataStore()
        }
        
        container.register(ConversionHistoryRouter.self) { r in
            return ConversionHistoryRouter()
        }.inObjectScope(.container)
        
        container.autoregister(ConversionHistoryPresenter.self, initializer: ConversionHistoryPresenter.init
        ).inObjectScope(.transient)
        
        container.autoregister(ConversionHistoryInteractor.self, initializer: ConversionHistoryInteractor.init
        ).inObjectScope(.transient)
        
        container.autoregister(
            ConversionHistoryViewController.self, initializer: ConversionHistoryViewController.init
        ).inObjectScope(.transient)
    }
}
