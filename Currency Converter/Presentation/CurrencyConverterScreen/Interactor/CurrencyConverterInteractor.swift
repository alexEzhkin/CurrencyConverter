//
//  CurrencyConverterInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import Foundation

class CurrencyConverterInteractor: BaseInteractor {
    
    private var currencyConverterPresenter: CurrencyConverterPresenter? {
        return presenter as? CurrencyConverterPresenter
    }
    
    func fetchExchangeRate() {
        guard let request = NetworkService.shared.createRequest(urlForRequest: EndPoint.exchange(fromAmount: 356.40, fromCurrency: "USD", toCurrency: "EUR").url, method: .get, parameters: nil) else { return }
        
        NetworkService.shared.getRequest(request: request, completion: { [weak self] (result: Result<CurrencyExchangeModel, NetworkError>) in
            switch result {
            case .success(let resultExchange):
                print(resultExchange)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
}
