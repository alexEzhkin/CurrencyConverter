//
//  ConversionHistoryPresenter.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Foundation

class ConversionHistoryPresenter: BasePresenter {
    weak var viewController: ConversionHistoryViewController?
    var router: ConversionHistoryRouter
    
    init(router: ConversionHistoryRouter) {
        self.router = router
    }
    
    func updateHistoryData(_ transactionHistory: [TransactionRealmObject]) {
        viewController?.showHistoryData(transactionHistory)
    }
}
