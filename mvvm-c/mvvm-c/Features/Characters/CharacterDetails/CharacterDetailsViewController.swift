//
//  CharacterDetailsViewController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 10/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: IVViewController<CharacterDetailsView> {

    var viewModel: CharacterDetailsViewModel!

    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setupOutputs() {
        super.setupOutputs()
        viewModel.nameDriver.drive(mainView.nameLabel.rx.text).disposed(by: disposeBag)
    }

}
