//
//  CharactersView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class CharactersView: UIView {

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        setupAppearance()
    }

}

extension CharactersView {

    private func setupAppearance() {
        backgroundColor = UIColor.red
    }

}
