//
//  MarvelCoordinator.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class MarvelCoordinator: Coordinator {
    var navigationController: NavigationController

    required init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let marvelViewController = MarvelViewController.instantiate(storyboard: R.storyboard.main()) as? MarvelViewController else { return }
        marvelViewController.viewModel = MarvelViewModel(coordinator: self)
        navigationController.pushViewController(marvelViewController, animated: false)
    }
}
