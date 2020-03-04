//
//  UINavigationBar.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

extension UINavigationBar {

    @IBInspectable var transparent: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.setBackgroundImage(UIImage(), for: .default)
                self.shadowImage = UIImage()
            } else {
                self.setBackgroundImage(nil, for: .default)
                self.shadowImage = nil
            }

        }
    }

}
