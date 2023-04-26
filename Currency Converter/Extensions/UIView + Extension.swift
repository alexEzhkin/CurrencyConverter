//
//  UIView + Extension.swift
//  Currency Converter
//
//  Created by AndUser on 03/04/2023.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveLinear,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
            }) {  (done) in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    options: .curveLinear,
                    animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    }) { [weak self] (_) in
                        self?.isUserInteractionEnabled = true
                        completionBlock()
                    }
            }
    }
}
