//
//  CharactersCoordinatorSpy.swift
//  mvvm-cTests
//
//  Created by Igor Vaz on 07/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
@testable import mvvm_c

class CharactersCoordinatorSpy: CharactersCoordinatorProtocol {
    var goToDetails = false

    var navigationController: NavigationController

    required init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {

    }

    func route(path: CoordinatorPath) {
        guard let path = path as? CharactersPath else { return }
        switch path {
        case .details:
            goToDetails = true
        }
    }
}
