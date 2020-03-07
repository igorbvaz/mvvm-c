//
//  ViewController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift

class ViewController<T: UIView>: UIViewController {
    let disposeBag = DisposeBag()

    var mainView = T()

    override func loadView() {
        view = mainView
    }
}
