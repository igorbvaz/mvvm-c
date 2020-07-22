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
    case root
    case tabItem
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
            let navigationController = UINavigationController()
            navigationController.navigationBar.transparent = true
            navigationController.setViewControllers([viewController], animated: false)
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill")?.withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal), style: .plain, target: viewController, action: #selector(viewController.dismissAnimated))
            UIApplication.topViewController()?.present(navigationController, animated: true, completion: nil)
        case .root:
            UIApplication.shared.windows.first?.rootViewController = viewController
        case .tabItem:
            let navigationController = UINavigationController(rootViewController: viewController)
            var newViewControllers = [UIViewController]()
            if let tabBarController = UIApplication.topViewController() as? UITabBarController {
                newViewControllers.append(contentsOf: tabBarController.viewControllers ?? [])
                newViewControllers.append(navigationController)
                tabBarController.setViewControllers(newViewControllers, animated: false)
            } else if let tabBarController = UIApplication.topViewController()?.tabBarController {
                newViewControllers.append(contentsOf: tabBarController.viewControllers ?? [])
                newViewControllers.append(navigationController)
                tabBarController.setViewControllers(newViewControllers, animated: false)
            }
        }
    }

    func back() {
        guard let navigationController = UIApplication.topViewController()?.navigationController else { return }

        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            navigationController.dismiss(animated: true, completion: nil)
        }
    }
}
