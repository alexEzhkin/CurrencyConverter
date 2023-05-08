//
//  CurrencyExchangeReceiveView.swift
//  Currency Converter
//
//  Created by AndUser on 01/04/2023.
//

import UIKit
import Stevia

class CurrencyExchangeReceiveView: BaseView, ExchangeAmountProtocol {
    weak var delegate: CurrencyViewInterface?
    
    var exchangeValue: String? {
        didSet {
            guard let exchangeValue = exchangeValue else {
                receiveCurrencyLabel.text = exchangeValue
                return
            }
            guard exchangeValue != "0" else {
                receiveCurrencyLabel.text = .none
                return
            }
            receiveCurrencyLabel.text = !exchangeValue.isEmpty ? "+ " + exchangeValue : exchangeValue
        }
    }
    
    var currency: Currencies {
        didSet {
            receiveCurrencyButton.setTitle(currency.segmentTitle, for: .normal)
        }
    }
   
    private let currencies = Currencies.allCases
    private let screenWidth = UIScreen.main.bounds.width - 10
    private let screenHeight = UIScreen.main.bounds.height / 2
    
    private let containerView = UIView()
    private let receiveImageIcon = UIImageView()
    private let receiveLabel = UILabel()
    private let receiveCurrencyLabel = UILabel()
    private let receiveCurrencyButton = UIButton()
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
        
        let alert = UIAlertController(title: "Select Receieve Currency", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = receiveCurrencyButton
        alert.popoverPresentationController?.sourceRect = receiveCurrencyButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.currency = self.currencies[pickerView.selectedRow(inComponent: 0)]
            self.delegate?.updateRates()
        }))
        
        guard let viewController = self.parentViewController else {
            return
        }
        viewController.present(alert, animated: true, completion: nil)
        
    }
}

// MARK: - Setups

private extension CurrencyExchangeReceiveView {
    func setUpView() {
        subviews {
            containerView.subviews {
                receiveImageIcon.style(receiveImageIconStyle)
                receiveLabel.style(receiveLabelStyle)
                receiveCurrencyLabel.style(receiveCurrencyLabelStyle)
                receiveCurrencyButton.style(receiveCurrencyButtonStyle)
                accessoryImage.style(accessoryImageStyle)
                separatLine.style(separatLineStyle)
            }
        }
        
        containerView
            .fillHorizontally()
        
        containerView.layout (
            0,
            |-0-receiveImageIcon.size(50)-10-receiveLabel-10-receiveCurrencyLabel-20-receiveCurrencyButton.width(40)-0-accessoryImage.width(20)-|,
            0,
            |-60-separatLine.height(0.5)-|,
            0
        )
    }
}

// MARK: - Styles

private extension CurrencyExchangeReceiveView {
    func receiveImageIconStyle(_ image: UIImageView) {
        receiveImageIcon.image = UIImage(systemName: "arrow.down.circle.fill")
        receiveImageIcon.tintColor = .systemGreen
    }
    
    func receiveLabelStyle(_ label: UILabel) {
        receiveLabel.text = "Receive"
    }
    
    func receiveCurrencyLabelStyle(_ label: UILabel) {
        receiveCurrencyLabel.textAlignment = .right
        receiveCurrencyLabel.textColor = .systemGreen
    }
    
    func receiveCurrencyButtonStyle(_ button: UIButton) {
        receiveCurrencyButton.setTitle(currency.segmentTitle, for: .normal)
        receiveCurrencyButton.setTitleColor(.black, for: .normal)
        receiveCurrencyButton.addTarget(self, action: #selector(popUpPicker), for: .touchUpInside)
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

extension CurrencyExchangeReceiveView: UIPickerViewDelegate, UIPickerViewDataSource {
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
