//
//  CurrencyConverterInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import Foundation
import PromiseKit

class CurrencyConverterInteractor: BaseInteractor {
    
    var presenter: CurrencyConverterPresenter!
    private let networkService: NetworkService
    private let converterService: ConverterService
    
    init(networkService: NetworkService, converterService: ConverterService) {
        self.networkService = networkService
        self.converterService = converterService
    }
    
    func fetchExchangeRate(amount: Double, fromCurrency: String, toCurrency: String) {
        firstly {
            networkService.createRequest(urlForRequest: EndPoint.exchange(fromAmount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency).url, method: .get, parameters: nil)
        }.then { request in
            self.networkService.getRequest(request: request)
        }.done { [weak self] (result: CurrencyExchangeModel) in
            self?.presenter.setExchangeRate(amount: result.amount)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
    
    func makeTransaction(_ transaction: Transaction, isTransactionFree: Bool) {
        let allBalances = converterService.getAllBalances()
        let currentSellBalance = allBalances[transaction.inputCurrency.lowercased()] as? Double ?? 0.0
        let sellAmountWithCommission = transaction.inputAmount + transaction.commission
        
        guard currentSellBalance >= sellAmountWithCommission else {
            return EventManager.shared.notifyFailure(transaction: transaction)
        }
        
        converterService.updateBalance(transaction)
        
        if isTransactionFree == false {
            EventManager.shared.notifySuccess(transaction: transaction)
        }
        
        converterService.incrementTransactionCount()
        presenter.setBalanceView()
    }
    
    func performTransaction(_ transaction: inout Transaction) {
        let currenctConversionsNumber = converterService.getTransactionCount()
        let isTransactionFree = converterService.checkFreeConversion(currenctConversionsNumber)
        
        if isTransactionFree == false {
            let commissionFee = converterService.calculateCommissionAmount(transaction, isTransactionFree: isTransactionFree)
            transaction.commission = commissionFee
        }
        makeTransaction(transaction, isTransactionFree: isTransactionFree)
    }
}
