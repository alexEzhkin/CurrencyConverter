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
    private let realm = try! Realm()
    
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
    
    func calculateBalance(sellCurrency: String, sellValue: Double, receiveCurrency: String, receiveValue: Double) {
        let currencyObject = realm.objects(CurrencyRealmObject.self).first!
        try! realm.write {
            if sellCurrency == "EUR" {
                currencyObject.eur = (currencyObject.eur - sellValue).roundTo(places: 2)
            } else if sellCurrency == "USD" {
                currencyObject.usd = (currencyObject.usd - sellValue).roundTo(places: 2)
            } else if sellCurrency == "JPY" {
                currencyObject.jpy = (currencyObject.jpy - sellValue).roundTo(places: 2)
            }

            if receiveCurrency == "EUR" {
                currencyObject.eur = (currencyObject.eur + receiveValue).roundTo(places: 2)
            } else if receiveCurrency == "USD" {
                currencyObject.usd = (currencyObject.usd + receiveValue).roundTo(places: 2)
            } else if receiveCurrency == "JPY" {
                currencyObject.jpy = (currencyObject.jpy + receiveValue).roundTo(places: 2)
            }
        }
        presenter.setBalanceView()
    }
}
