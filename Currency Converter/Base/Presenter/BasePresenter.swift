//
//  BasePresenter.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//
import UIKit

protocol BasePresenterProtocol {
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

class BasePresenter: BasePresenterProtocol {
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
