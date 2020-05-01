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

protocol Coordinator {
    func start(presentationStyle: PresentationStyle)
    func route(path: CoordinatorPath)
}

extension Coordinator {

    func show(viewController: UIViewController, presentationStyle: PresentationStyle) {
        switch presentationStyle {
        case .push:
            if let navigationController = UIApplication.topViewController()?.navigationController {
                navigationController.pushViewController(viewController, animated: true)
            } else if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: false)
            }
        case .modal:
            let navigationController = NavigationController()
            navigationController.setViewControllers([viewController], animated: false)
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: viewController, action: #selector(viewController.dismissAnimated))
            UIApplication.topViewController()?.present(navigationController, animated: true, completion: nil)
        }
    }

    func finish() {
        
    }
}
