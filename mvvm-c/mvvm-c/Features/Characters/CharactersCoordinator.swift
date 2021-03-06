//
//  CharactersCoordinator.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

enum CharactersPath: CoordinatorPath {
    case details(character: Character)
}
protocol CharactersCoordinatorProtocol: Coordinator {}

class CharactersCoordinator: CharactersCoordinatorProtocol {

    var navigationController: NavigationController

    required init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let charactersViewController = CharactersViewController(viewModel: CharactersViewModel(coordinator: self))
        navigationController.pushViewController(charactersViewController, animated: false)
    }

    func route(path: CoordinatorPath) {
        guard let path = path as? CharactersPath else { return }
        switch path {
        case .details(let character):
            let viewController = CharacterDetailsViewController(viewModel: CharacterDetailsViewModel(coordinator: self, character: character))
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
