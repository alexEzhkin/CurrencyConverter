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
}
