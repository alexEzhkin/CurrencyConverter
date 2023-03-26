//
//  BaseViewController.swift
//  Currency Converter
//
//  Created by AndUser on 24/03/2023.
//

import UIKit

class BaseViewController: UIViewController {
    let interactor: BaseInteractor
    let presenter: BasePresenter
    let customView: BaseView

    init(interactor: BaseInteractor, presenter: BasePresenter, customView: BaseView) {
        self.interactor = interactor
        self.presenter = presenter
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        presenter.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
}
