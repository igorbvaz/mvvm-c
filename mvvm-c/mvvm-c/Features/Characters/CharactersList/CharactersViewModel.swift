//
//  CharactersViewModel.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift

protocol CharactersViewModelInput {

}

protocol CharactersViewModelOutput {

}

class CharactersViewModel: ViewModel {
    var disposeBag = DisposeBag()

    init(coordinator: CharactersCoordinator) {
        
    }
}
