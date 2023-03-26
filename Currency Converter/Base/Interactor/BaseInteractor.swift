//
//  BaseInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import Foundation

class BaseInteractor {
    weak var presenter: BasePresenter<BaseView>?
    
    init(presenter: BasePresenter<BaseView>) {
        self.presenter = presenter
    }
}
