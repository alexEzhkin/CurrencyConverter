//
//  ConversionHistoryInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Foundation

class ConversionHistoryInteractor: BaseInteractor {
    
    var presenter: ConversionHistoryPresenter!
    private let historyDataService: HistoryDataStoreProtocol
    
    init(historyDataService: HistoryDataStoreProtocol) {
        self.historyDataService = historyDataService
    }
    
    func fetchHistoryData() {
        let transactionHistory = historyDataService.getTransactionHistory()
        
        transferHistoryData(transactionHistory)
    }
    
    func transferHistoryData(_ transactionHistory: [TransactionRealmObject]) {
        presenter.updateHistoryData(transactionHistory)
    }
}
