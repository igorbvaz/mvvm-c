//
//  EmptyStateView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 07/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    private var stackView = UIStackView()
    var imageImageView = UIImageView()
    var textLabel = UILabel()

    private var text: String?
    private var image: UIImage?
    var padding: Int!

    convenience init(size: CGSize, text: String, image: UIImage? = UIImage(), padding: Int = 32) {
        self.init(frame: CGRect(origin: .zero, size: size))
        self.text = text
        self.image = image
        self.padding = padding
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
            make.edges.equalToSuperview().inset(padding)
        }

        setupImageView()
        setupTextLabel()
    }

    private func setupImageView() {
        stackView.addArrangedSubview(imageImageView)

        imageImageView.image = image
        imageImageView.tintColor = UIColor.lightGray
        imageImageView.contentMode = .scaleAspectFit
    }

    private func setupTextLabel() {
        stackView.addArrangedSubview(textLabel)

        textLabel.text = text
//        textLabel.font = UIFont(name: "Euphemia UCAS", size: 24)
        textLabel.textColor = UIColor.lightGray
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
    }
}
