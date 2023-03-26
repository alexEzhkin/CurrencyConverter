//
//  BaseRouter.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit

class BaseRouter {
    fileprivate(set) weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func dismissSCreen() {
        view?.dismiss(animated: true)
    }
    
    func popCurrentScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
}
