//
//  BaseView.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit
import Stevia

protocol BaseViewProtocol: AnyObject {
    func setupView()
}

class BaseView: UIView, BaseViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}

