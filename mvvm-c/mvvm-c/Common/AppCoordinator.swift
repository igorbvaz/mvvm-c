//
//  AppCoordinator.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
//    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController!

//    required init(navigationController: NavigationController) {
//        self.childCoordinators = []
//        self.navigationController = navigationController
//    }

    func start(presentationStyle: PresentationStyle) {
//        let charactersCoordinator = CharactersCoordinator()
//        childCoordinators.append(charactersCoordinator)
        CharactersCoordinator().start(presentationStyle: presentationStyle)
    }

    func route(path: CoordinatorPath) {}

}
