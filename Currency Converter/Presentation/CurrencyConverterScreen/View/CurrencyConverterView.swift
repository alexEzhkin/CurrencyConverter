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
        }
        layout {
            |-20-myBalanceLabel.height(15)-|
            25
            |-20-balanceScrollView.height(40)-|
            25
            |-20-currencyExchangeLabel.height(15)-|
            15
            |-20-currencySellView.height(15)-|
        }
        myBalanceLabel.Top == safeAreaLayoutGuide.Top + 30
    }
}
