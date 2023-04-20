//
//  ViewController.swift
//  Currency Converter
//
//  Created by AndUser on 23/03/2023.
//

import UIKit
import RxSwift

class CurrencyConverterViewController: BaseViewController<CurrencyConverterView>, CurrencyViewInterface {
    
    private let interactor: CurrencyConverterInteractor
    private let disposeBag = DisposeBag()
    
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
        customView.view = self
        customView.currencySellView.view = self
        customView.currencyReceiveView.view = self
        
        doBindings()
        configureNavigationBar()
    }
    
    func doBindings() {
        EventManager.shared.observeSuccess()
            .subscribe(onNext: { [weak self] transaction in
                self?.showCommissionFeeAlert(transaction)
            })
            .disposed(by: disposeBag)
        
        EventManager.shared.observeFailure()
            .subscribe(onNext: { [weak self] transaction in
                self?.showConversionErrorAlert(transaction)
            })
            .disposed(by: disposeBag)
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
    
    func updateBalance() {
        let sellCurrency = customView.currencySellView.currency.segmentTitle
        let sellAmount = customView.currencySellView.sellAmount
        let receiveCurrency = customView.currencyReceiveView.currency.segmentTitle
        let receiveAmount = Double(customView.currencyReceiveView.exchangeValue!)!
        var transaction = Transaction(inputAmount: sellAmount, inputCurrency: sellCurrency, outputAmount: receiveAmount, outputCurrency: receiveCurrency, commission: 0.0)
        
        interactor.performTransaction(&transaction)
    }
    
    func updateBalanceView() {
        customView.balanceScrollView.setBalances()
    }
    
    func showConversionErrorAlert(_ transaction: Transaction) {
        let messageAlert = UIAlertController(title: "Conversion Error",
                                             message: "Sorry, but you don't have enough funs to convert from \(transaction.inputCurrency) to \(transaction.outputCurrency)",
                                             preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default)
        messageAlert.addAction(action)
        present(messageAlert, animated: true)
    }
    
    func showCommissionFeeAlert(_ transaction: Transaction) {
        let messageAlert = UIAlertController(title: "Currency Converted",
                                             message: "You have converted \(transaction.inputAmount) \(transaction.inputCurrency) to \(transaction.outputAmount) \(transaction.outputCurrency). Commission Fee - \(transaction.commission.roundTo(places: 2)) \(transaction.inputCurrency)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default)
        messageAlert.addAction(action)
        present(messageAlert, animated: true)
    }
}
