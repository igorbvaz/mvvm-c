//
//  CharactersView.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import SnapKit

class CharactersView: IVView {

    var tableView = UITableView()

    override func setup() {
        super.setup()
        setupTableView()
    }

}

extension CharactersView {

    private func setupTableView() {
        addSubview(tableView)

        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().priority(.high)
            make.left.right.bottom.equalToSuperview()
        }

    }
}
