//
//  ConversionHistoryInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Foundation

class ConversionHistoryInteractor: BaseInteractor {
    
    var presenter: ConversionHistoryPresenter!
    private let converterService: ConverterService
    
    init(converterService: ConverterService) {
        self.converterService = converterService
    }
    
    func fetchHistoryData() {
        let transactionHistory = converterService.getTransactionHistory()
        
        transferHistoryData(transactionHistory)
    }
    
    func transferHistoryData(_ transactionHistory: [TransactionRealmObject]) {
        presenter.updateHistoryData(transactionHistory)
    }
}
