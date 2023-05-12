//
//  HistoryDetailPresenter.swift
//  Currency Converter
//
//  Created by AndUser on 12/05/2023.
//

import Foundation

class HistoryDetailPresenter: BasePresenter {
    weak var viewController: HistoryDetailViewController?
    var router: HistoryDetailRouter
    
    init(router: HistoryDetailRouter) {
        self.router = router
    }
}
