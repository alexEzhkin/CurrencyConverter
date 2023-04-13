//
//  CurrencyConverterPresenter.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import Foundation

class CurrencyConverterPresenter: BasePresenter {
    
    weak var viewController: CurrencyConverterViewController?
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear() {
    }
    
    override func viewWillDisappear() {
    }
    
    func setExchangeRate(amount: String) {
        viewController?.updateReceiveLabel(with: amount)
    }
    
    func setBalanceView() {
        viewController?.updateBalanceView()
    }
}
