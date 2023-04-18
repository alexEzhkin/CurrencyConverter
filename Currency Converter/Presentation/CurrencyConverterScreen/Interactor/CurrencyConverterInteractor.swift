//
//  CurrencyConverterInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import Foundation
import RealmSwift

class CurrencyConverterInteractor: BaseInteractor {
    
    var presenter: CurrencyConverterPresenter!
    private let networkService: NetworkService
    private let transactionService: TransactionServiceProtocol
    private let feeService: FeeServiceProtocol
    private let realm = try! Realm()
    
    init(networkService: NetworkService, transactionService: TransactionServiceProtocol, feeService: FeeServiceProtocol) {
        self.networkService = networkService
        self.transactionService = transactionService
        self.feeService = feeService
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
        let currencyObject = realm.objects(CurrencyRealmObject.self).first!
        let currentSellValue = currencyObject.value(forKey: transaction.inputCurrency.lowercased()) as? Double
        let sellAmount = transaction.inputAmount + transaction.commission
        
        guard currentSellValue! >= sellAmount else {
            return showErrorAlert(transaction)
        }
        
        try! realm.write {
            if transaction.inputCurrency == "EUR" {
                currencyObject.eur = (currencyObject.eur - sellAmount).roundTo(places: 2)
            } else if transaction.inputCurrency == "USD" {
                currencyObject.usd = (currencyObject.usd - sellAmount).roundTo(places: 2)
            } else if transaction.inputCurrency == "JPY" {
                currencyObject.jpy = (currencyObject.jpy - sellAmount).roundTo(places: 2)
            }
            
            if transaction.outputCurrency == "EUR" {
                currencyObject.eur = (currencyObject.eur + transaction.outputAmount).roundTo(places: 2)
            } else if transaction.outputCurrency == "USD" {
                currencyObject.usd = (currencyObject.usd + transaction.outputAmount).roundTo(places: 2)
            } else if transaction.outputCurrency == "JPY" {
                currencyObject.jpy = (currencyObject.jpy + transaction.outputAmount).roundTo(places: 2)
            }
        }
        
        if isTransactionFree == false {
            showCommissionFeeAlert(transaction)
        }
        
        feeService.incrementTransactionCount()
        presenter.setBalanceView()
    }
    
    func showErrorAlert(_ transaction: Transaction){
        presenter.viewController?.showConversionErrorAlert(transaction)
    }
    
    func showCommissionFeeAlert(_ transaction: Transaction) {
        presenter.viewController?.showCommissionFeeAlert(transaction)
    }
    
    func performTransaction(_ transaction: inout Transaction) {
        let isTransactionFree = feeService.checkFreeConversion()
        
        if isTransactionFree == false {
            let commissionFee = transactionService.calculateCommissionAmount(transaction, isTransactionFree: isTransactionFree)
            transaction.commission = commissionFee
        }
        makeTransaction(transaction, isTransactionFree: isTransactionFree)
    }
}
