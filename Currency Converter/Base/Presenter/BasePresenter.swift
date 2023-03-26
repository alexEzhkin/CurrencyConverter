//
//  BasePresenter.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit

class BasePresenter<V: BaseView> {
    
    weak var view: V?
    let router: BaseRouter
    
    init(view: V, router: BaseRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
