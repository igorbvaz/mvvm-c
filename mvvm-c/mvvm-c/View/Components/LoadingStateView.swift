//
//  LoadingStateView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 07/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingStateView: UIView {

    private var stackView = UIStackView()
    var activityIndicatorView: NVActivityIndicatorView!
    var textLabel = UILabel()

    private var text: String?

    convenience init(size: CGSize, activityIndicator: NVActivityIndicatorType = .ballRotateChase, text: String = "") {
        self.init(frame: CGRect(origin: .zero, size: size))
        self.text = text
        self.activityIndicatorView = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 32, height: 32)), type: .ballRotateChase, color: UIColor.lightGray, padding: 0)
        setup()
    }

    private func setup() {
        setupStackView()
    }

    private func setupStackView() {
        addSubview(stackView)

        stackView.axis = .vertical
        stackView.spacing = 8

        stackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        setupActivityIndicatorView()
        setupTextLabel()
    }

    private func setupActivityIndicatorView() {
        stackView.addArrangedSubview(activityIndicatorView)

        activityIndicatorView.startAnimating()
    }

    private func setupTextLabel() {
        stackView.addArrangedSubview(textLabel)

        textLabel.text = text
        textLabel.font = UIFont(name: "Euphemia UCAS", size: 12)
        textLabel.textColor = UIColor.lightGray
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
    }

}
