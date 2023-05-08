//
//  ConversionHistoryViewController.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Foundation
import UIKit

class ConversionHistoryViewController: BaseViewController<ConversionHistoryView> {
    
    private let interactor: ConversionHistoryInteractor
    
    init(interactor: ConversionHistoryInteractor, presenter: ConversionHistoryPresenter) {
        self.interactor = interactor
        super.init()
        presenter.viewController = self
        interactor.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        getHistoryData()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        title = "History"
    }
    
    func getHistoryData() {
        interactor.fetchHistoryData()
    }
    
    func showHistoryData(_ transactionHistory: [TransactionRealmObject]) {
        customView.setHistoryData(transactionHistory)
    }
}
