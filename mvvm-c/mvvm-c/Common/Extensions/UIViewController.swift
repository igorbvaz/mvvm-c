//
//  UIViewController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

extension UIViewController {

    static func instantiate(storyboard: UIStoryboard) -> UIViewController {
        let viewControllerName = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: viewControllerName)
    }

}
