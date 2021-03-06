//
//  AppCoordinator.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: NavigationController

    required init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let charactersCoordinator = CharactersCoordinator(navigationController: navigationController)
        charactersCoordinator.start()
    }

    func route(path: CoordinatorPath) {}

}
