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
    
    init(networkService: NetworkService) {
        self.networkService = networkService
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
}
