//
//  BaseViewController.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit

class BaseViewController<View: BaseView>: UIViewController {
    let customView: View
    
    init() {
        customView = View()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .customBlueColor
        appearance.titleTextAttributes = textAttributes
        navigationItem.standardAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactScrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
