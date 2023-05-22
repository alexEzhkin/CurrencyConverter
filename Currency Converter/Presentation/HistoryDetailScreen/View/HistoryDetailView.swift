//
//  HistoryDetailView.swift
//  Currency Converter
//
//  Created by AndUser on 12/05/2023.
//

import Foundation
import UIKit
import Stevia


class HistoryDetailView: BaseView {
        
    private let containerView = UIView()
    private let sellCurrencyImage = UIImageView()
    private let exchangeImage = UIImageView()
    private let receiveCurrencyImage = UIImageView()
    private let transactionDateLabel = UILabel()
    private let sellLabel = UILabel()
    private let sellValueLabel = UILabel()
    private let receiveLabel = UILabel()
    private let receiveValueLabel = UILabel()
    private let commissionLabel = UILabel()
    private let commissionValueLabel = UILabel()
    private let separateLine = UIView()
    private let transactionStatusLabel = UILabel()
    private let transactionStatusImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTransaction(_ transaction: TransactionRealmObject) {
        
        sellCurrencyImage.image = UIImage(named: transaction.inputCurrency)
        receiveCurrencyImage.image = UIImage(named: transaction.outputCurrency)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        let formattedDate = dateFormatter.string(from: transaction.transactionDate)
        
        transactionDateLabel.text = formattedDate
        
        sellLabel.text = "Base currency: "
        sellValueLabel.text = "- \(transaction.inputAmount) \(transaction.inputCurrency)"
        receiveLabel.text = "Output currency: "
        receiveValueLabel.text = "+ \(transaction.outputAmount) \(transaction.outputCurrency)"
        commissionLabel.text = "Commission fee: "
        commissionValueLabel.text = "- \(transaction.commission) \(transaction.inputCurrency)"
        
        if transaction.transactionStatus {
            transactionStatusLabel.text = "Transaction succeed"
            transactionStatusLabel.textColor = .systemGreen
            transactionStatusImage.image = UIImage(systemName: "checkmark.circle.fill")
            transactionStatusImage.tintColor = .systemGreen
        } else {
            transactionStatusLabel.text = "Transaction failed"
            transactionStatusLabel.textColor = .systemRed
            transactionStatusImage.image = UIImage(systemName: "checkmark.circle.badge.xmark.fill")
            transactionStatusImage.tintColor = .systemRed
        }
    }
}

private extension HistoryDetailView {
    func setUpView() {
        backgroundColor = .systemBackground
        
        containerView.subviews {
            sellCurrencyImage.style(sellCurrencyImageStyle)
            exchangeImage.style(exchangeImageStyle)
            receiveCurrencyImage.style(receiveCurrencyImageStyle)
        }
        
        containerView.layout(
            0,
            |-(>=10)-sellCurrencyImage.size(50)-20-exchangeImage.size(100)-20-receiveCurrencyImage.size(50)-(>=10)-|,
            0
        )
        
        subviews {
            containerView
            transactionDateLabel.style(transactionDateLabelStyle)
            sellLabel
            sellValueLabel.style(sellValueLabelStyle)
            receiveLabel
            receiveValueLabel.style(receiveValueLabelStyle)
            commissionLabel
            commissionValueLabel.style(commissionValueLabelStyle)
            separateLine.style(separateLineStyle)
            transactionStatusLabel.style(transactionStatusLabelStyle)
            transactionStatusImage
        }
        
        layout(
            containerView.centerHorizontally(),
            30,
            transactionDateLabel.centerHorizontally(),
            30,
            |-15-sellLabel|,
            15,
            |-15-sellValueLabel|,
            15,
            |-15-receiveLabel|,
            15,
            |-15-receiveValueLabel|,
            15,
            |-15-commissionLabel|,
            15,
            |-15-commissionValueLabel|,
            30,
            |-0-separateLine.height(1)-0-|,
            30,
            transactionStatusLabel.centerHorizontally(),
            10,
            transactionStatusImage.centerHorizontally().size(70)
        )
        
        containerView.Top == safeAreaLayoutGuide.Top + 50
    }
}

private extension HistoryDetailView {
    func sellCurrencyImageStyle(_ image: UIImageView) {
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func exchangeImageStyle(_ image: UIImageView) {
        image.image = UIImage(named: "ExchangeIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func receiveCurrencyImageStyle(_ image: UIImageView) {
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func transactionDateLabelStyle(_ label: UILabel) {
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    func sellValueLabelStyle(_ label: UILabel) {
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    func receiveValueLabelStyle(_ label: UILabel) {
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    func commissionValueLabelStyle(_ label: UILabel) {
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    func separateLineStyle(_ view: UIView) {
        view.backgroundColor = .opaqueSeparator
    }
    
    func transactionStatusLabelStyle(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 27)
    }
}
