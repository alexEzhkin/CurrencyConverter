//
//  BaseViewController.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit

class BaseViewController<View: BaseView>: UIViewController {
    
    var interactor: BaseInteractor?
    var presenter: BasePresenter?
    let customView: View
    
    init() {
        customView = View()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
}
