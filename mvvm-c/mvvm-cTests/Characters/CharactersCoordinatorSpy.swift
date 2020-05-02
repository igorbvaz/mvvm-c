//
//  CharactersCoordinatorSpy.swift
//  mvvm-cTests
//
//  Created by Igor Vaz on 07/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
@testable import mvvm_c

class CharactersCoordinatorSpy: Coordinator {

    var goToDetails = false

    func start(presentationStyle: PresentationStyle) {

    }

    func route(path: CoordinatorPath) {
        guard let path = path as? CharactersPath else { return }
        switch path {
        case .details:
            goToDetails = true
        }
    }
}
