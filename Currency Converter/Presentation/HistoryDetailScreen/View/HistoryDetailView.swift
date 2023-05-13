//
//  HistoryDetailView.swift
//  Currency Converter
//
//  Created by AndUser on 12/05/2023.
//

import Foundation

class HistoryDetailView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTransaction(_ transaction: TransactionRealmObject) {
        
    }
}

private extension HistoryDetailView {
    func setUpView() {
        backgroundColor = .red
    }
}
