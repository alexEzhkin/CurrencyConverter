//
//  ConversionHistoryView.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Stevia
import UIKit
import RealmSwift

protocol ConversionHistoryViewProtocol: AnyObject {
    func getHistoryData()
}

class ConversionHistoryView: BaseView {
    
    weak var delegate: ConversionHistoryViewProtocol?
    
    let historyTableView = UITableView()
    var historyData: [TransactionRealmObject] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHistoryData(_ transactionHistory: [TransactionRealmObject]) {
        historyData = transactionHistory
    }
}

// MARK: - Setups

private extension ConversionHistoryView {
    func setUpView() {
        subviews {
            historyTableView
        }
        
        historyTableView.fillContainer()
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.register(ConversionHistoryCell.self, forCellReuseIdentifier: "conversionHistoryCell")
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ConversionHistoryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.getHistoryData()
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversionHistoryCell", for: indexPath) as! ConversionHistoryCell
        let data = historyData[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}
