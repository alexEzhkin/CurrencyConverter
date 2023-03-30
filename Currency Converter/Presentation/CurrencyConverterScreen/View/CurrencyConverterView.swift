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
        subviews {
            myBalanceLabel
        }
        layout {
            |-20-myBalanceLabel.height(15)-|
        }
        myBalanceLabel.Top == safeAreaLayoutGuide.Top + 30
    }
}
