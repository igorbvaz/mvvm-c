//
//  Coordinator.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: NavigationController { get }
    init(navigationController: NavigationController)
    func start()
}
