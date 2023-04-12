//
//  ViewController.swift
//  Currency Converter
//
//  Created by AndUser on 23/03/2023.
//

import UIKit

class CurrencyConverterViewController: BaseViewController<CurrencyConverterView>, CurrencyExchangeSellToViewControllerProtocol {
    
    private let interactor: CurrencyConverterInteractor
    
    init(interactor: CurrencyConverterInteractor, presenter: CurrencyConverterPresenter) {
        self.interactor = interactor
        super.init()
        presenter.viewController = self
        interactor.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.currencySellView.view = self
        customView.currencyReceiveView.view = self
        configureNavigationBar()
    }
    
    func updateRates() {
        let amount = customView.currencySellView.sellAmount
        let inputCurrency = customView.currencySellView.currency.segmentTitle
        let outputCurrency = customView.currencyReceiveView.currency.segmentTitle
        interactor.fetchExchangeRate(amount: amount, fromCurrency: inputCurrency, toCurrency: outputCurrency)
    }
    
    func updateReceiveLabel(with amount: String) {
        customView.currencyReceiveView.exchangeValue = amount
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
