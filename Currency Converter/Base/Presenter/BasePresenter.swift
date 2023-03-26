//
//  BasePresenter.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit

class BasePresenter {
    
    weak var viewController: BaseViewController?
    
    fileprivate let router: BaseRouter
    
    init(router: BaseRouter) {
        self.router = router
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
