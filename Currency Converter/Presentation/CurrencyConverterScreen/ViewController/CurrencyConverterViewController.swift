//
//  ViewController.swift
//  Currency Converter
//
//  Created by AndUser on 23/03/2023.
//

import UIKit
import RxSwift

class CurrencyConverterViewController: BaseViewController<CurrencyConverterView> {
    
    private let interactor: CurrencyConverterInteractor
    private let disposeBag = DisposeBag()
    
    init(interactor: CurrencyConverterInteractor, presenter: CurrencyConverterPresenter) {
        self.interactor = interactor
        super.init()
        presenter.viewController = self
        presenter.router.viewController = self
        interactor.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        customView.currencySellView.delegate = self
        customView.currencyReceiveView.delegate = self
        
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
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        title = "Currency converter"
        
        let historyButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(historyButtonTapped))
        navigationItem.rightBarButtonItem = historyButton
    }
    
    @objc func historyButtonTapped() {
        let module = interactor.presenter.router.createModule()
        
        interactor.presenter.router.pushModule(module, animated: true)
    }
    
    func updateBalanceView() {
        customView.balanceScrollView.setBalances()
    }
    
    func updateReceiveLabel(with amount: String) {
        customView.currencyReceiveView.exchangeValue = amount
    }
    
    func showConversionErrorAlert(_ transaction: Transaction) {
        let conversionErrorAlert = ConversionAlertFactory.showAlert(title: "Conversion Error", description: "Sorry, but you don't have enough funs to convert from \(transaction.inputCurrency) to \(transaction.outputCurrency)")
        present(conversionErrorAlert, animated: true)
    }
    
    func showCommissionFeeAlert(_ transaction: Transaction) {
        let commissionAlert = ConversionAlertFactory.showAlert(title: "Currency Converted", description: "You have converted \(transaction.inputAmount) \(transaction.inputCurrency) to \(transaction.outputAmount) \(transaction.outputCurrency). Commission Fee - \(transaction.commission.roundTo(places: 2)) \(transaction.inputCurrency)")
        present(commissionAlert, animated: true)
    }
}

// MARK: - CurrencyViewInterface

extension CurrencyConverterViewController: CurrencyViewInterface {
    func updateRates() {
        let amount = customView.currencySellView.sellAmount
        let inputCurrency = customView.currencySellView.currency.segmentTitle
        let outputCurrency = customView.currencyReceiveView.currency.segmentTitle
        interactor.fetchExchangeRate(
            amount: amount,
            fromCurrency: inputCurrency,
            toCurrency: outputCurrency
        )
    }
    
    func updateBalance() {
        let sellCurrency = customView.currencySellView.currency.segmentTitle
        let sellAmount = customView.currencySellView.sellAmount
        let receiveCurrency = customView.currencyReceiveView.currency.segmentTitle
        let receiveAmount = Double(customView.currencyReceiveView.exchangeValue!)!
        var transaction = Transaction(
            inputAmount: sellAmount,
            inputCurrency: sellCurrency,
            outputAmount: receiveAmount,
            outputCurrency: receiveCurrency,
            commission: 0.0
        )
        
        interactor.performTransaction(&transaction)
    }
}
