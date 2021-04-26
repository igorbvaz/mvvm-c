//
//  IVViewController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift

class IVViewController<T: IVView>: UIViewController {
    let disposeBag = DisposeBag()

    var mainView = T()

    override func loadView() {
        view = mainView
        mainView.setupNavigationBar(navigationBar: navigationController?.navigationBar)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        setupOutputs()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.didLayoutSubviews()
    }

    @objc func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    func setupInputs() {}

    func setupOutputs() {}
}
