//
//  CurrencyConverterPresenter.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import Foundation

class CurrencyConverterPresenter: BasePresenter {
    
    weak var viewController: CurrencyConverterViewController?
    
    func setExchangeRate(amount: String) {
        viewController?.updateReceiveLabel(with: amount)
    }
    
    func setBalanceView() {
        viewController?.updateBalanceView()
    }
}
