//
//  ConversionHistoryRouter.swift
//  Currency Converter
//
//  Created by AndUser on 26/04/2023.
//

import Foundation
import UIKit

protocol ConversionHistoryRouterProtocol: BaseRouterProtocol {
    func createModule(with transaction: TransactionRealmObject) -> UIViewController
}

class ConversionHistoryRouter: BaseRouter {
    weak var viewController: UIViewController?
    
    override func presentModule(_ module: UIViewController, animated: Bool) {
        viewController?.present(module, animated: animated, completion: nil)
    }
    
    override func pushModule(_ module: UIViewController, animated: Bool) {
        viewController?.navigationController?.pushViewController(module, animated: animated)
    }
}

extension ConversionHistoryRouter: ConversionHistoryRouterProtocol {
    func createModule(with transaction: TransactionRealmObject) -> UIViewController {
        guard let module = DI.shared.resolve(HistoryDetailViewController.self) else {
            return UIViewController()
        }
        module.transaction = transaction
        
        return module
    }
}
