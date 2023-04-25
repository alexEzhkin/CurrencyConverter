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

protocol CurrencyViewInterface: AnyObject {
    func updateRates()
    func updateBalance()
}

class CurrencyExchangeSellView: BaseView {
    weak var delegate: ExchangeAmountProtocol?
    weak var view: CurrencyViewInterface?
    
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
    
    private let containerView = UIView()
    private let sellImageIcon = UIImageView()
    private let sellLabel = UILabel()
    private let sellCurrencyTextField = UITextField()
    private let sellCurrencyButton = UIButton()
    private let accessoryImage = UIImageView()
    private let separatLine = UIView()
    
    
    override init(frame: CGRect) {
        self.currency = currencies.first ?? .EUR
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        sellCurrencyTextField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        sellCurrencyTextField.resignFirstResponder()
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
}

// MARK: - Setups

private extension CurrencyExchangeSellView {
    func setUpView() {
        subviews {
            containerView.subviews {
                sellImageIcon.style(sellImageIconStyle)
                sellLabel.style(sellLabelStyle)
                sellCurrencyTextField.style(sellCurrencyTextFieldStyle)
                sellCurrencyButton.style(sellCurrencyButtonStyle)
                accessoryImage.style(accessoryImageStyle)
                separatLine.style(separatLineStyle)
            }
        }
        
        containerView
            .fillHorizontally()
        
        containerView.layout(
            0,
            |-0-sellImageIcon.size(50)-10-sellLabel-10-sellCurrencyTextField-20-sellCurrencyButton.width(40)-0-accessoryImage.width(20)-|,
            0,
            |-60-separatLine.height(0.5)-|,
            0
        )
    }
}

// MARK: - Styles

private extension CurrencyExchangeSellView {
    func sellImageIconStyle(_ image: UIImageView) {
        sellImageIcon.image = UIImage(systemName: "arrow.up.circle.fill")
        sellImageIcon.tintColor = .red
    }
    
    func sellLabelStyle(_ label: UILabel) {
        sellLabel.text = "Sell"
    }
    
    func sellCurrencyTextFieldStyle(_ textField: UITextField) {
        sellCurrencyTextField.placeholder = "0"
        sellCurrencyTextField.textAlignment = .right
        sellCurrencyTextField.keyboardType = .decimalPad
        sellCurrencyTextField.delegate = self
    }
    
    func sellCurrencyButtonStyle(_ button: UIButton) {
        sellCurrencyButton.setTitle(currency.segmentTitle, for: .normal)
        sellCurrencyButton.setTitleColor(.black, for: .normal)
        sellCurrencyButton.addTarget(self, action: #selector(popUpPicker), for: .touchUpInside)
    }
    
    func accessoryImageStyle(_ image: UIImageView) {
        accessoryImage.image = UIImage(systemName: "chevron.down")
        accessoryImage.tintColor = .black
    }
    
    func separatLineStyle(_ view: UIView) {
        separatLine.backgroundColor = .opaqueSeparator
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension CurrencyExchangeSellView: UIPickerViewDelegate, UIPickerViewDataSource {
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

// MARK: - UITextFieldDelegate

extension CurrencyExchangeSellView: UITextFieldDelegate {
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: ",", with: ".")
        
        if let text = textField.text, let value = Double(text) {
            self.sellAmount = value
            view?.updateRates()
        }
    }
}
