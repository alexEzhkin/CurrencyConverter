//
//  BalancesScrollView.swift
//  Currency Converter
//
//  Created by AndUser on 31/03/2023.
//

import UIKit
import Stevia

class BalancesScrollView: BaseView {
    
    public var balances: [String] = ["EUR 1000.00", "USD 0.00", "JPY 0.00"]
    private let scrollView = UIScrollView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.subviews.first?.isHidden = false
    }

    func setUpView() {
        subviews {
            scrollView
        }

        scrollView.Top == Top
        scrollView.Bottom == Bottom
        scrollView.Left == Left
        scrollView.Right == Right

        setBalances()
    }

    func setBalances() {
        
        guard balances.count > 0 else {
            return
        }

        let balanceView = setUpBalanceView()
        let balanceLabels = setUpBalanceLabels()

        var lastLabel: UILabel! = .none
        balanceLabels.enumerated().forEach { index, balanceLabel in
            balanceView.subviews {
                balanceLabel
            }
            balanceLabel.Top == balanceView.Top
            balanceLabel.Bottom == balanceView.Bottom

            if index == 0 {
                balanceLabel.Left == balanceView.Left
            } else {
                balanceLabel.Left == lastLabel.Right + 20
            }
            lastLabel = balanceLabel
        }
        
        lastLabel.Right == balanceView.Right
        
        setNeedsLayout()
        layoutIfNeeded()
    }


    func setUpBalanceView() -> UIView {
        let balanceView = UILabel()

        scrollView.subviews {
            balanceView
        }
        
        balanceView.fillContainer()
        balanceView.Left == scrollView.contentLayoutGuide.Left
        balanceView.Left == scrollView.contentLayoutGuide.Left
        balanceView.Top == scrollView.contentLayoutGuide.Top
        balanceView.Bottom == scrollView.contentLayoutGuide.Bottom
        balanceView.Top == scrollView.frameLayoutGuide.Top
        balanceView.Bottom == scrollView.frameLayoutGuide.Bottom

        return balanceView
    }

    func setUpBalanceLabels() -> [UILabel] {
        balances.map { balance in
            let label = UILabel()
            label.text = balance.description
            return label
        }
    }
}
