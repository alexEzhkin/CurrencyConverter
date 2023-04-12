//
//  CurrencyConverterRouter.swift
//  Currency Converter
//
//  Created by AndUser on 27/03/2023.
//

import Foundation
import UIKit

class CurrencyConverterRouter: BaseRouter {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let presenter = CurrencyConverterPresenter()
        let interactor = CurrencyConverterInteractor()
        let viewController = CurrencyConverterViewController(interactor: interactor, presenter: presenter)
        let router = CurrencyConverterRouter()
        
        router.viewController = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    override func presentModule(_ module: UIViewController, animated: Bool) {
        viewController?.present(module, animated: animated, completion: nil)
    }
    
    override func pushModule(_ module: UIViewController, animated: Bool) {
        viewController?.navigationController?.pushViewController(module, animated: animated)
    }
}
