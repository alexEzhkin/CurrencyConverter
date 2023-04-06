//
//  ViewController.swift
//  Currency Converter
//
//  Created by AndUser on 23/03/2023.
//

import UIKit

class CurrencyConverterViewController: BaseViewController<CurrencyConverterView>, CurrencyExchangeSellToViewControllerProtocol {
    
    private var currencyPresenter: CurrencyConverterPresenter? {
        return presenter as? CurrencyConverterPresenter
    }
    
    private var currencyConverterInteractror: CurrencyConverterInteractor? {
        return interactor as? CurrencyConverterInteractor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        customView.currencySellView.view = self
        configureNavigationBar()
    }
    
    func updateRates() {
        currencyPresenter?.getExchangeRate()
    }
    
    func configureNavigationBar() {
        title = "Currency converter"
        let appearance = UINavigationBarAppearance()
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .customBlueColor
        appearance.titleTextAttributes = textAttributes
        navigationItem.standardAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactScrollEdgeAppearance = appearance
    }
}
