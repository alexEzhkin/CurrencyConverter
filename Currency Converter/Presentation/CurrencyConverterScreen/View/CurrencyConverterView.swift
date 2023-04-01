//
//  CurrencyConverterView.swift
//  Currency Converter
//
//  Created by AndUser on 26/03/2023.
//

import UIKit
import Stevia

class CurrencyConverterView: BaseView {
    
    let myBalanceLabel = UILabel()
    let balanceScrollView = BalancesScrollView()
    let currencyExchangeLabel = UILabel()
    let currencySellView = CurrencyExchangeSellView()
    let currencyReceiveView = CurrencyExchangeReceiveView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpView() {
        backgroundColor = .systemBackground
        
        myBalanceLabel.text = "MY BALANCES"
        currencyExchangeLabel.text = "CURRENCY EXCHANGE"
        subviews {
            myBalanceLabel
            balanceScrollView
            currencyExchangeLabel
            currencySellView
            currencyReceiveView
        }
        layout {
            |-20-myBalanceLabel.height(15)-|
            25
            |-20-balanceScrollView.height(40)-|
            25
            |-20-currencyExchangeLabel.height(15)-|
            25
            |-20-currencySellView.height(60)-|
            10
            |-20-currencyReceiveView.height(60)-|
        }
        myBalanceLabel.Top == safeAreaLayoutGuide.Top + 30
    }
}
