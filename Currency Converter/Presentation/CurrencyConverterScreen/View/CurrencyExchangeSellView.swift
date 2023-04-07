//
//  CurrencyExchangeSellView.swift
//  Currency Converter
//
//  Created by AndUser on 31/03/2023.
//

import UIKit
import Stevia

protocol ExchangeAmountProtocol: AnyObject {
    var exchangeValue: String? { get set }
}

protocol CurrencyExchangeSellToViewControllerProtocol: AnyObject {
    func updateRates()
}

class CurrencyExchangeSellView: BaseView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    weak var delegate: ExchangeAmountProtocol?
    weak var view: CurrencyExchangeSellToViewControllerProtocol?
    
    var sellAmount: Double = 0.0
    
    var currency: Currencies {
        didSet {
            sellCurrencyButton.setTitle(currency.segmentTitle, for: .normal)
        }
    }
    
    private let currencies = Currencies.allCases
    private let screenWidth = UIScreen.main.bounds.width - 10
    private let screenHeight = UIScreen.main.bounds.height / 2
    private let roundedPlace = 2
        
    private let sellImageIcon: UIImageView
    private let sellLabel: UILabel
    private let sellCurrencyTextField: UITextField
    private let sellCurrencyButton: UIButton
    private let accessoryImage: UIImageView
    private let separatLine: UIView
    
    init() {
        self.currency = currencies.first ?? .EUR
        self.sellImageIcon = UIImageView(frame: .zero)
        self.sellLabel = UILabel(frame: .zero)
        self.sellCurrencyTextField = UITextField(frame: .zero)
        self.sellCurrencyButton = UIButton(frame: .zero)
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
        sellCurrencyTextField.delegate = self
        
        sellCurrencyButton.setTitle(currency.segmentTitle, for: .normal)
        sellCurrencyButton.setTitleColor(.black, for: .normal)
        sellCurrencyButton.addTarget(self, action: #selector(popUpPicker), for: .touchUpInside)
        
        separatLine.backgroundColor = .opaqueSeparator
        
        subviews {
            sellImageIcon
            sellLabel
            sellCurrencyTextField
            sellCurrencyButton
            accessoryImage
            separatLine
        }
        
        align(horizontally: [self, sellImageIcon, sellLabel, sellCurrencyTextField, sellCurrencyButton, accessoryImage])
        sellImageIcon.Left == Left
        sellImageIcon.height(50).width(50)
        sellLabel.Left == sellImageIcon.Right + 10
        sellLabel.height(50)
        sellCurrencyTextField.height(50)
        sellCurrencyTextField.Left == sellLabel.Right + 10
        sellCurrencyButton.Left == sellCurrencyTextField.Right + 20
        sellCurrencyButton.height(50).width(40)
        sellCurrencyButton.Right == accessoryImage.Left
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: ",", with: ".")
        
        if let text = textField.text, let value = Double(text) {
            self.sellAmount = value
            view?.updateRates()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if (textField.text?.contains("."))! && string == "." {
            return false
        }
        if (textField.text?.contains("."))! {
            let decimalPlace = textField.text?.components(separatedBy: ".").last
            if (decimalPlace?.count)! < roundedPlace {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    @IBAction func popUpPicker(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(currency.segmentIndex, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Sell Currency", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = sellCurrencyButton
        alert.popoverPresentationController?.sourceRect = sellCurrencyButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.currency = self.currencies[pickerView.selectedRow(inComponent: 0)]
            self.view?.updateRates()
        }))
        
        guard let viewController = self.parentViewController else {
            return
        }
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencies[row].segmentTitle
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 50
    }
}
