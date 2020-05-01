//
//  CharactersView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import SnapKit

class CharactersView: UIView {

    var tableView = UITableView()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        setupAppearance()
        setupTableView()
    }

}

extension CharactersView {

    private func setupAppearance() {
        backgroundColor = R.color.background()
    }

    private func setupTableView() {
        addSubview(tableView)

        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().priority(.high)
            make.left.right.bottom.equalToSuperview()
        }

    }
}
