//
//  HistoryDetailViewController.swift
//  Currency Converter
//
//  Created by AndUser on 12/05/2023.
//

import Foundation

class HistoryDetailViewController: BaseViewController<HistoryDetailView> {
    
    private let interactor: HistoryDetailInteractor
    
    init(interactor: HistoryDetailInteractor, presenter: HistoryDetailPresenter) {
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
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        title = "Transaction Details"
    }
}
