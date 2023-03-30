//
//  BaseInteractor.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import Foundation

protocol BaseInteractorProtocol {
    var presenter: BasePresenter? { get set }
}

class BaseInteractor: BaseInteractorProtocol {
    
    var presenter: BasePresenter?
}
