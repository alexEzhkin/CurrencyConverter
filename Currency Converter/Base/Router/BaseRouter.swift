//
//  BaseRouter.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit

protocol BaseRouterProtocol {
    func createModule()
}

class BaseRouter: BaseRouterProtocol {
    
    func createModule() {}
    func presentModule(_ module: UIViewController, animated: Bool) {}
    func pushModule(_ module: UIViewController, animated: Bool) {}
}
