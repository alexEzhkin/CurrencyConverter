//
//  CurrencyExchangeReceiveView.swift
//  Currency Converter
//
//  Created by AndUser on 01/04/2023.
//

import UIKit
import Stevia

class CurrencyExchangeReceiveView: BaseView {
    private let receiveImageIcon: UIImageView
    private let receiveLabel: UILabel
    private let receiveCurrencyLabel: UILabel
    private let receiveCurrencyPicker: UIPickerView
    private let accessoryImage: UIImageView
    
    init() {
        self.receiveImageIcon = UIImageView(frame: .zero)
        self.receiveLabel = UILabel(frame: .zero)
        self.receiveCurrencyLabel = UILabel(frame: .zero)
        self.receiveCurrencyPicker = UIPickerView(frame: .zero)
        self.accessoryImage = UIImageView(frame: .zero)
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        receiveLabel.text = "Receive"
        receiveImageIcon.image = UIImage(systemName: "arrow.down.circle.fill")
        receiveImageIcon.tintColor = .systemGreen
        accessoryImage.image = UIImage(systemName: "chevron.down")
        accessoryImage.tintColor = .black
        
        subviews {
            receiveImageIcon
            receiveLabel
            receiveCurrencyLabel
            receiveCurrencyPicker
            accessoryImage
        }
        
        align(horizontally: [self, receiveImageIcon, receiveLabel, receiveCurrencyLabel, receiveCurrencyPicker, accessoryImage])
        receiveImageIcon.Left == Left
        receiveImageIcon.height(50).width(50)
        receiveLabel.Left == receiveImageIcon.Right + 10
        receiveLabel.height(50)
        receiveCurrencyLabel.height(50)
        receiveCurrencyLabel.Left == receiveLabel.Right + 10
        receiveCurrencyLabel.Left == receiveCurrencyLabel.Right + 20
        receiveCurrencyPicker.height(50).width(70)
        receiveCurrencyPicker.Right == accessoryImage.Left
        accessoryImage.height(20).width(20)
        accessoryImage.Right == Right
    }
}
