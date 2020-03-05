//
//  CharactersCoordinator.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class CharactersCoordinator: Coordinator {
    var navigationController: NavigationController

    required init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let charactersViewController = CharactersViewController(viewModel: CharactersViewModel(coordinator: self))
        navigationController.pushViewController(charactersViewController, animated: false)
    }
}
