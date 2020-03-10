//
//  CharacterDetailsView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 10/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class CharacterDetailsView: UIView {

    var nameLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        backgroundColor = R.color.background()
        setupNameLabel()
    }

}

extension CharacterDetailsView {
    private func setupNameLabel() {
        addSubview(nameLabel)

        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        nameLabel.textAlignment = .center
    }
}
