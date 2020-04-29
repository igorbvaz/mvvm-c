//
//  UIViewController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 28/04/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

extension UIViewController {

    @objc func dismissAnimated() {
        self.dismiss(animated: true, completion: nil)
    }

}
