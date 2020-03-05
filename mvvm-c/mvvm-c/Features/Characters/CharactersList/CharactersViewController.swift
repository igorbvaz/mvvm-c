//
//  CharactersViewController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class CharactersViewController: ViewController {

    var viewModel: CharactersViewModel!

    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func loadView() {
        view = CharactersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
