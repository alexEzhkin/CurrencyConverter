//
//  ConversionHistoryCell.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import UIKit
import Stevia

class ConversionHistoryCell: UITableViewCell {
    
    static let reuseIdentifier = "ConversionHistoryCell"
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with transaction: TransactionRealmObject) {
        label.text = "\(transaction.inputAmount) \(transaction.inputCurrency) = \(transaction.outputAmount) \(transaction.outputCurrency) with \(transaction.commission) \(transaction.inputCurrency): \(transaction.transactionStatus)"
    }
}

// MARK: - Setups

private extension ConversionHistoryCell {
    func setUpView() {
        contentView.subviews {
            label
        }
        
        label.fillContainer()
    }
}
