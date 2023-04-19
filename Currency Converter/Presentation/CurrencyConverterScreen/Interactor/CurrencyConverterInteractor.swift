//
//  CurrencyConverterInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import Foundation

class CurrencyConverterInteractor: BaseInteractor {
    
    var presenter: CurrencyConverterPresenter!
    private let networkService: NetworkService
    private let converterService: ConverterService
    
    init(networkService: NetworkService, converterService: ConverterService) {
        self.networkService = networkService
        self.converterService = converterService
    }
    
    func fetchExchangeRate(amount: Double, fromCurrency: String, toCurrency: String) {
        guard let request = networkService.createRequest(urlForRequest: EndPoint.exchange(fromAmount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency).url, method: .get, parameters: nil) else { return }
        
        networkService.getRequest(request: request, completion: { [weak self] (result: Result<CurrencyExchangeModel, NetworkError>) in
            switch result {
            case .success(let resultExchange):
                self?.presenter.setExchangeRate(amount: resultExchange.amount)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func makeTransaction(_ transaction: Transaction, isTransactionFree: Bool) {
        let allBalances = converterService.getAllBalances()
        let currentSellBalance = allBalances[transaction.inputCurrency.lowercased()] as? Double ?? 0.0
        let sellAmountWithCommission = transaction.inputAmount + transaction.commission
        
        guard currentSellBalance >= sellAmountWithCommission else {
            return showErrorAlert(transaction)
        }
        
        converterService.updateBalance(transaction)
        
        if isTransactionFree == false {
            showCommissionFeeAlert(transaction)
        }
        
        converterService.incrementTransactionCount()
        presenter.setBalanceView()
    }
    
    func showErrorAlert(_ transaction: Transaction){
        presenter.viewController?.showConversionErrorAlert(transaction)
    }
    
    func showCommissionFeeAlert(_ transaction: Transaction) {
        presenter.viewController?.showCommissionFeeAlert(transaction)
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
