//
//  CharacterDetailsView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 10/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class CharacterDetailsView: IVView {

    var nameLabel = UILabel()

    override func setup() {
        super.setup()
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
