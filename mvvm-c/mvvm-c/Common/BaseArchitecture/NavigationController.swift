//
//  NavigationController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    init(transparent: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        navigationBar.transparent = transparent
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
