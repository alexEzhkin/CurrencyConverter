//
//  HistoryDetailRouter.swift
//  Currency Converter
//
//  Created by AndUser on 12/05/2023.
//

import Foundation
import UIKit

class HistoryDetailRouter: BaseRouter {
    weak var viewController: UIViewController?
    
    override func presentModule(_ module: UIViewController, animated: Bool) {
        viewController?.present(module, animated: animated, completion: nil)
    }
    
    override func pushModule(_ module: UIViewController, animated: Bool) {
        viewController?.navigationController?.pushViewController(module, animated: animated)
    }
}
