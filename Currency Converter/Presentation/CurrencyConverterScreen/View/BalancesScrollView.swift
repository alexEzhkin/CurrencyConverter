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
    
    private var balances: [(key: String, value: Double)] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(BalanceCell.self, forCellWithReuseIdentifier: BalanceCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.subviews.first?.isHidden = false
    }
    
    func setBalances() {
        let currencyFromRealm = try! Realm().objects(CurrencyRealmObject.self).first!
        balances = currencyFromRealm.toDictionary().sorted(by: { $0.value > $1.value })
        
        guard balances.count > 0 else {
            return
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - Setups

private extension BalancesScrollView {
    func setUpView() {
        subviews {
            collectionView
        }
        
        collectionView
            .fillContainer()
        
        setBalances()
    }
}

// MARK: - UICollectionViewDataSource

extension BalancesScrollView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return balances.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BalanceCell.reuseIdentifier, for: indexPath) as! BalanceCell
        let balance = Array(balances)[indexPath.item]
        cell.configure(with: balance.key, value: balance.value)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BalancesScrollView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let balance = Array(balances)[indexPath.item]
        let cell = BalanceCell(frame: .zero)
        cell.configure(with: balance.key, value: balance.value)
        cell.layoutIfNeeded()
        let size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        return CGSize(width: size.width + 20, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
