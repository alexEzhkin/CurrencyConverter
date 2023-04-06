//
//  CurrencyConverterPresenter.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import Foundation

class CurrencyConverterPresenter: BasePresenter {
    
    weak var viewController: CurrencyConverterViewController?
    
    private var currencyConverterInteractor: CurrencyConverterInteractor? {
        return interactor as? CurrencyConverterInteractor
    }
    
    init(viewController: CurrencyConverterViewController) {
        self.viewController = viewController
    }
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear() {
    }
    
    override func viewWillDisappear() {
    }
    
    func getExchangeRate() {
        currencyConverterInteractor?.fetchExchangeRate()
    }
}
