//
//  HistoryDetailAssembly.swift
//  Currency Converter
//
//  Created by AndUser on 12/05/2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class HistoryDetailAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
        container.register(HistoryDetailRouter.self) { r in
            return HistoryDetailRouter()
        }.inObjectScope(.container)
        
        container.autoregister(HistoryDetailPresenter.self, initializer: HistoryDetailPresenter.init
        ).inObjectScope(.transient)
        
        container.autoregister(HistoryDetailInteractor.self, initializer: HistoryDetailInteractor.init
        ).inObjectScope(.transient)
        
        container.autoregister(
            HistoryDetailViewController.self, initializer: HistoryDetailViewController.init
        ).inObjectScope(.transient)
    }
}
