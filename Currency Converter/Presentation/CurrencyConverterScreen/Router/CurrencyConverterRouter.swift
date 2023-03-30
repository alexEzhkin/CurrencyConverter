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
        let viewController = CurrencyConverterViewController()
        let presenter = CurrencyConverterPresenter(viewController: viewController)
        let interactor = CurrencyConverterInteractor()
        let router = CurrencyConverterRouter()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = viewController
        
        return viewController
    }
    
    override func presentModule(_ module: UIViewController, animated: Bool) {
        viewController?.present(module, animated: animated, completion: nil)
    }
    
    override func pushModule(_ module: UIViewController, animated: Bool) {
        viewController?.navigationController?.pushViewController(module, animated: animated)
    }
}
