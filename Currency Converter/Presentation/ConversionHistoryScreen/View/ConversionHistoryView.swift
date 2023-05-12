//
//  ConversionHistoryView.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Stevia
import UIKit
import RxSwift
import RxCocoa

protocol ConversionHistoryViewProtocol: AnyObject {
    func showTransactionDetails()
}

class ConversionHistoryView: BaseView {
    
    weak var delegate: ConversionHistoryViewProtocol?
    
    let historyTableView = UITableView()
    let historyData = BehaviorRelay<[TransactionRealmObject]>(value: [])
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHistoryData(_ transactionHistory: [TransactionRealmObject]) {
        historyData.accept(transactionHistory)
    }
}

// MARK: - Setups

private extension ConversionHistoryView {
    func setUpView() {
        subviews {
            historyTableView
        }
        
        historyTableView.fillContainer()
        historyTableView.register(ConversionHistoryCell.self, forCellReuseIdentifier: "conversionHistoryCell")
        
        historyTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        historyData
            .bind(to: historyTableView.rx.items(
                cellIdentifier: "conversionHistoryCell",
                cellType: ConversionHistoryCell.self)
            ) { [weak self] _, data, cell in
                cell.configure(with: data)
                
                self?.historyTableView.beginUpdates()
                self?.historyTableView.endUpdates()
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension ConversionHistoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversionHistoryCell") as! ConversionHistoryCell
        let cellHeight = CGFloat(cell.defaultCellHeight)
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        delegate?.showTransactionDetails()
    }
}
