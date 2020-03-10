//
//  CharacterDetailsViewModel.swift
//  mvvm-c
//
//  Created by Igor Vaz on 10/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CharacterDetailsViewModelInputs {}

protocol CharacterDetailsViewModelOutputs {
    var nameDriver: Driver<String> { get }
}

protocol CharacterDetailsViewModelProtocol: ViewModelProtocol {
    var inputs: CharacterDetailsViewModelInputs { get }
    var outputs: CharacterDetailsViewModelOutputs { get }
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol, CharacterDetailsViewModelInputs {
    var inputs: CharacterDetailsViewModelInputs { return self }
    var outputs: CharacterDetailsViewModelOutputs { return self }

    var disposeBag = DisposeBag()

    var characterReplaySubject = ReplaySubject<Character>.create(bufferSize: 1)
    var coordinator: CharactersCoordinatorProtocol

    init(coordinator: CharactersCoordinatorProtocol, service: CharactersServiceProtocol = CharactersService(), character: Character) {
        self.coordinator = coordinator
        self.characterReplaySubject.onNext(character)
    }

}

extension CharacterDetailsViewModel: CharacterDetailsViewModelOutputs {
    var nameDriver: Driver<String> {
        return characterReplaySubject.map { $0.name }.asDriver(onErrorJustReturn: "")
    }
}
