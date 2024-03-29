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

    func start(presentationStyle: PresentationStyle) {
        let charactersViewController = CharactersViewController(viewModel: CharactersViewModel(coordinator: self))
        UINavigationController().pushViewController(charactersViewController, animated: true)
        show(viewController: charactersViewController, presentationStyle: presentationStyle)
    }

    func route(path: CoordinatorPath) {
        guard let path = path as? CharactersPath else { return }
        switch path {
        case .details(let character):
            let viewController = CharacterDetailsViewController(viewModel: CharacterDetailsViewModel(coordinator: self, character: character))
            show(viewController: viewController, presentationStyle: .modal)
        }
    }
    
}
