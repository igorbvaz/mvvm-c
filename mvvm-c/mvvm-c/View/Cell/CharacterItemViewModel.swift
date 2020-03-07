//
//  CharacterItemViewModel.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift

protocol CharacterItemViewModelOutputs {

}
class CharacterItemViewModel: ViewModelProtocol {
    var disposeBag = DisposeBag()

    var character: Character

    init(character: Character) {
        self.character = character
    }

}

extension CharacterItemViewModel: CharacterItemViewModelOutputs {
    var name: String {
        return character.name
    }
}
