//
//  CurrencyExchangeReceiveView.swift
//  Currency Converter
//
//  Created by AndUser on 01/04/2023.
//

import UIKit
import Stevia

class CurrencyExchangeReceiveView: BaseView, UIPickerViewDelegate, UIPickerViewDataSource {
    private let currencies = Currencies.allCases
    private let screenWidth = UIScreen.main.bounds.width - 10
    private let screenHeight = UIScreen.main.bounds.height / 2
    
    private lazy var selectedRow = currencies.first?.segmentIndex ?? 0
    
    private let receiveImageIcon: UIImageView
    private let receiveLabel: UILabel
    private let receiveCurrencyLabel: UILabel
    private let receiveCurrencyButton: UIButton
    private let accessoryImage: UIImageView
    private let separatLine: UIView
    
    init() {
        self.receiveImageIcon = UIImageView(frame: .zero)
        self.receiveLabel = UILabel(frame: .zero)
        self.receiveCurrencyLabel = UILabel(frame: .zero)
        self.receiveCurrencyButton = UIButton(frame: .zero)
        self.accessoryImage = UIImageView(frame: .zero)
        self.separatLine = UIView(frame: .zero)
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
        
        receiveCurrencyButton.setTitle(currencies[selectedRow].segmentTitle, for: .normal)
        receiveCurrencyButton.setTitleColor(.black, for: .normal)
        receiveCurrencyButton.addTarget(self, action: #selector(popUpPicker), for: .touchUpInside)
        
        separatLine.backgroundColor = .opaqueSeparator
        
        subviews {
            receiveImageIcon
            receiveLabel
            receiveCurrencyLabel
            receiveCurrencyButton
            accessoryImage
            separatLine
        }
        
        align(horizontally: [self, receiveImageIcon, receiveLabel, receiveCurrencyLabel, receiveCurrencyButton, accessoryImage])
        receiveImageIcon.Left == Left
        receiveImageIcon.height(50).width(50)
        receiveLabel.Left == receiveImageIcon.Right + 10
        receiveLabel.height(50)
        receiveCurrencyLabel.height(50)
        receiveCurrencyLabel.Left == receiveLabel.Right + 10
        receiveCurrencyLabel.Left == receiveCurrencyLabel.Right + 20
        receiveCurrencyButton.height(50).width(40)
        receiveCurrencyButton.Right == accessoryImage.Left
        accessoryImage.height(20).width(20)
        accessoryImage.Right == Right
        separatLine.height(0.5)
        separatLine.Left == receiveLabel.Left
        separatLine.Right == Right
        separatLine.Bottom == Bottom
    }
    
    @IBAction func popUpPicker(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Sell Currency", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = receiveCurrencyButton
        alert.popoverPresentationController?.sourceRect = receiveCurrencyButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = self.selectedRow
            let name = self.currencies[selected].segmentTitle
            self.receiveCurrencyButton.setTitle(name, for: .normal)
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