//
//  CurrencyExchangeSellView.swift
//  Currency Converter
//
//  Created by AndUser on 31/03/2023.
//

import UIKit
import Stevia

class CurrencyExchangeSellView: BaseView {
    private let sellImageIcon: UIImageView
    private let sellLabel: UILabel
    private let sellCurrencyTextField: UITextField
    private let sellCurrencyPicker: UIPickerView
    private let accessoryImage: UIImageView
    private let separatLine: UIView
    
    init() {
        self.sellImageIcon = UIImageView(frame: .zero)
        self.sellLabel = UILabel(frame: .zero)
        self.sellCurrencyTextField = UITextField(frame: .zero)
        self.sellCurrencyPicker = UIPickerView(frame: .zero)
        self.accessoryImage = UIImageView(frame: .zero)
        self.separatLine = UIView(frame: .zero)
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        sellLabel.text = "Sell"
        sellImageIcon.image = UIImage(systemName: "arrow.up.circle.fill")
        sellImageIcon.tintColor = .red
        accessoryImage.image = UIImage(systemName: "chevron.down")
        accessoryImage.tintColor = .black
        
        sellCurrencyTextField.placeholder = "0"
        sellCurrencyTextField.textAlignment = .right
        sellCurrencyTextField.keyboardType = .decimalPad
        
        separatLine.backgroundColor = .opaqueSeparator
        
        subviews {
            sellImageIcon
            sellLabel
            sellCurrencyTextField
            sellCurrencyPicker
            accessoryImage
            separatLine
        }
        
        align(horizontally: [self, sellImageIcon, sellLabel, sellCurrencyTextField, sellCurrencyPicker, accessoryImage])
        sellImageIcon.Left == Left
        sellImageIcon.height(50).width(50)
        sellLabel.Left == sellImageIcon.Right + 10
        sellLabel.height(50)
        sellCurrencyTextField.height(50)
        sellCurrencyTextField.Left == sellLabel.Right + 10
        sellCurrencyPicker.Left == sellCurrencyTextField.Right + 20
        sellCurrencyPicker.height(50).width(70)
        sellCurrencyPicker.Right == accessoryImage.Left
        accessoryImage.height(20).width(20)
        accessoryImage.Right == Right
        separatLine.height(0.5)
        separatLine.Left == sellLabel.Left
        separatLine.Right == Right
        separatLine.Bottom == Bottom
    }
    
    override func becomeFirstResponder() -> Bool {
        sellCurrencyTextField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        sellCurrencyTextField.resignFirstResponder()
    }
}
