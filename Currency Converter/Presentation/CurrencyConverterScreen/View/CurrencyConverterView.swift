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
    let submitButton = UIButton()
    var submitButtonBottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpView() {
        currencySellView.delegate = currencyReceiveView
        
        backgroundColor = .systemBackground
        
        myBalanceLabel.text = "MY BALANCES"
        currencyExchangeLabel.text = "CURRENCY EXCHANGE"
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.layer.cornerRadius = 25
        submitButton.backgroundColor = .customBlueColor
        subviews {
            myBalanceLabel
            balanceScrollView
            currencyExchangeLabel
            currencySellView
            currencyReceiveView
            submitButton
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
            >=0
            |-(30)-submitButton.height(50)-30-|
        }
        submitButton.bottom(50).centerHorizontally().height(50)
        myBalanceLabel.Top == safeAreaLayoutGuide.Top + 30
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let distanceToMove = 15 - keyboardFrame.height
        
        if submitButtonBottomConstraint == nil {
            submitButtonBottomConstraint = submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: distanceToMove)
            submitButtonBottomConstraint?.isActive = true
        } else {
            submitButtonBottomConstraint?.constant = distanceToMove
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        submitButtonBottomConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
