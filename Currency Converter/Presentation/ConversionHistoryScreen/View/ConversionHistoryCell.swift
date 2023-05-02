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
    
    let transactionContainer = UIView()
    let transactionStatusContainer = UIView()
    let mainContainer = UIView()
    let sellLabel = UILabel()
    let transactionIcon = UIImageView()
    let receiveLabel = UILabel()
    let commissionLabel = UILabel()
    let transatcionStatusLabel = UILabel()
    let transactionStatusImage = UIImageView()
    
    let defaultCellHeight: Double = 100
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with transaction: TransactionRealmObject) {
        sellLabel.text = "\(transaction.inputAmount) \(transaction.inputCurrency)"
        receiveLabel.text = "\(transaction.outputAmount) \(transaction.outputCurrency)"
        commissionLabel.text = "Commission fee: \(transaction.commission) \(transaction.inputCurrency)"
        
        if transaction.transactionStatus {
            transatcionStatusLabel.text = "Transaction succeed"
            transactionStatusImage.image = UIImage(systemName: "checkmark.circle.fill")
            transactionStatusImage.tintColor = .green
        } else {
            transatcionStatusLabel.text = "Transaction failed"
            transactionStatusImage.image = UIImage(systemName: "checkmark.circle.badge.xmark.fill")
            transactionStatusImage.tintColor = .red
        }
    }
}

// MARK: - Setups

private extension ConversionHistoryCell {
    func setUpView() {
        transactionContainer.subviews {
            sellLabel
            transactionIcon.style(transactionImageStyle)
            receiveLabel
        }

        transactionContainer.layout (
            0,
            |-sellLabel-transactionIcon.size(30)-receiveLabel-|,
            0
        )

        transactionStatusContainer.subviews {
            transatcionStatusLabel
            transactionStatusImage
        }

        transactionStatusContainer.layout (
            0,
            |-transatcionStatusLabel-transactionStatusImage.size(30)-|,
            0
        )

        subviews {
            mainContainer.subviews {
                transactionContainer
                commissionLabel
                transactionStatusContainer
            }
        }

        layout (
            10,
            |-transactionContainer-|,
            10,
            |-commissionLabel-|,
            10,
            |-transactionStatusContainer-|,
            0
        )

        mainContainer.centerHorizontally()
    }
}

private extension ConversionHistoryCell {
    func transactionImageStyle(_ image: UIImageView) {
        transactionIcon.image = UIImage(systemName: "arrow.left.arrow.right.circle.fill")
        transactionIcon.tintColor = .black
    }
}
