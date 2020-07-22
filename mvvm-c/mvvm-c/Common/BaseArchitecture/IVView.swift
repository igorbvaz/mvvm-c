//
//  IVView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 21/07/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class IVView: UIView {

    let disposeBag = DisposeBag()
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    required init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = R.color.background()
    }

    func setupNavigationBar(navigationBar: UINavigationBar?) {}
    func didLayoutSubviews() {}

    func showActivityIndicator() {
        if activityIndicator.superview == nil {
            self.addSubview(activityIndicator)

            activityIndicator.hidesWhenStopped = true

            activityIndicator.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }

}
