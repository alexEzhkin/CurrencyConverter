//
//  BalanceCell.swift
//  Currency Converter
//
//  Created by AndUser on 13/04/2023.
//

import Foundation
import UIKit
import Stevia

class BalanceCell: UICollectionViewCell {
    
    static let reuseIdentifier = "BalanceCell"
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        contentView.subviews {
            label.style(labelStyle)
        }
        
        label
            .top(0)
            .bottom(0)
            .right(0)
            .left(0)
    }
    
    func configure(with key: String, value: Double) {
        label.text = "\(value) \(key)"
    }
}

private extension BalanceCell {
    func labelStyle(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
    }
}
