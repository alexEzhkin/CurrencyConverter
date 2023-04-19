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
    private let balanceDataService: BalanceDataStoreProtocol
    private let realm = try! Realm()
    
    init(networkService: NetworkService, transactionService: TransactionServiceProtocol, feeService: FeeServiceProtocol, balanceDataService: BalanceDataStoreProtocol) {
        self.networkService = networkService
        self.transactionService = transactionService
        self.feeService = feeService
        self.balanceDataService = balanceDataService
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
        let allBalances = balanceDataService.getAllBalances()
        let currentSellBalance = allBalances[transaction.inputCurrency.lowercased()] as? Double ?? 0.0
        let sellAmountWithCommission = transaction.inputAmount + transaction.commission
        
        guard currentSellBalance >= sellAmountWithCommission else {
            return showErrorAlert(transaction)
        }
        
        balanceDataService.updateBalance(transaction)
        
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
