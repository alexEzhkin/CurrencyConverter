//
//  BasePresenter.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//
import UIKit

protocol BasePresenterProtocol {
    var interactor: BaseInteractor? { get set }
    var router: BaseRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

class BasePresenter: BasePresenterProtocol {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
