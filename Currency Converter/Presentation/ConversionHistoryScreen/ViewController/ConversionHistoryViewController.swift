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
        presenter.router.viewController = self
        interactor.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        
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

extension ConversionHistoryViewController: ConversionHistoryViewProtocol {
    func showTransactionDetails() {
        let module = interactor.presenter.router.createModule()
        
        interactor.presenter.router.pushModule(module, animated: true)
    }
}
