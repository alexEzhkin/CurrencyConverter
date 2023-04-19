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
        
        container.register(NetworkService.self) { r in
            return NetworkService()
        }
                
        container.register(FeeServiceProtocol.self) { r in
            return FeeService()
        }
        
        container.register(TransactionServiceProtocol.self) { r in
            return TransactionService()
        }
        
        container.register(BalanceDataStoreProtocol.self) { r in
            return BalanceDataStore()
        }
        
        container.register(FeeLimitDataStoreProtocol.self) { r in
            return FeeLimitDataStore()
        }
        
        container.register(CurrencyConverterPresenter.self) { r in
            return CurrencyConverterPresenter()
        }.inObjectScope(.container)
        
        container.register(CurrencyConverterRouter.self) { r in
            return CurrencyConverterRouter()
        }.inObjectScope(.container)
        
        container.autoregister(CurrencyConverterInteractor.self, initializer: CurrencyConverterInteractor.init
        ).inObjectScope(.transient)
        
        container.autoregister(
            CurrencyConverterViewController.self, initializer: CurrencyConverterViewController.init
        ).inObjectScope(.transient)
    }
}

