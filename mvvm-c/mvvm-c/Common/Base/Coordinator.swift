//
//  Coordinator.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

enum PresentationStyle {
    case push
    case modal
}

protocol CoordinatorPath {}

protocol Coordinator: NSObject, UINavigationControllerDelegate {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: NavigationController { get set }
    init(navigationController: NavigationController)
    func start(presentationStyle: PresentationStyle)
    func route(path: CoordinatorPath)
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func isPopping() -> UIViewController? {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return nil }
        if navigationController.viewControllers.contains(fromViewController) { return nil }
        return fromViewController
    }

    func show(viewController: UIViewController, presentationStyle: PresentationStyle) {
        switch presentationStyle {
        case .push:
            self.navigationController.pushViewController(viewController, animated: true)
        case .modal:
            let navigationController = NavigationController()
            navigationController.setViewControllers([viewController], animated: false)
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: viewController, action: #selector(viewController.dismissAnimated))
            self.navigationController.topViewController?.present(navigationController, animated: true, completion: nil)
        }
    }

    func finish() {
        
    }
}
