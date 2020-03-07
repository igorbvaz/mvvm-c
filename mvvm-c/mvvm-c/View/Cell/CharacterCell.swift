//
//  CharacterCell.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import SnapKit

class CharacterCell: UITableViewCell {

    var characterImageView = UIImageView()
    var nameLabel = UILabel()

    var viewModel: CharacterItemViewModel! {
        didSet {
            bindViewModel()
        }
    }

    private func bindViewModel() {
        nameLabel.text = viewModel.name
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        setupNameLabel()
    }

}

extension CharacterCell {
    private func setupNameLabel() {
        addSubview(nameLabel)

        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
