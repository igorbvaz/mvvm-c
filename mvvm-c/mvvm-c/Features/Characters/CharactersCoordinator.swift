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
class CharactersCoordinator: Coordinator {

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
            print("Going to Details Screen with character: \(character.name)")
        }
    }
}
