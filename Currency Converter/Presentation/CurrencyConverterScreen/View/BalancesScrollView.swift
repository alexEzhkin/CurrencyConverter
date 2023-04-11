//
//  BalancesScrollView.swift
//  Currency Converter
//
//  Created by AndUser on 31/03/2023.
//

import UIKit
import Stevia
import RealmSwift

class BalancesScrollView: BaseView {
        
    private var balances = ["": 0.00]
    
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
        let currencyFromRealm = try! Realm().objects(CurrencyRealmObject.self).first!
        balances = currencyFromRealm.toDictionary()
        
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
        balances.sorted(by: { $0.value > $1.value}).map { balance in
            let label = UILabel()
            label.text = String(balance.value) + " " + balance.key
            return label
        }
    }
}
