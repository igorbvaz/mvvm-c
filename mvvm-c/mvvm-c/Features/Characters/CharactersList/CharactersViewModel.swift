//
//  CharactersViewModel.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

protocol CharactersViewModelInputs {
    var didAppear: PublishSubject<Void> { get }
    var endOfList: PublishSubject<Void> { get }
    var characterSelected: PublishSubject<Character> { get }
    var willDisplayCharacterCell: PublishSubject<IndexPath> { get }
}

protocol CharactersViewModelOutputs {
    var dataSource: Driver<[SectionViewModel<CharacterItemViewModel>]> { get }
    var showCharactersLoadingStateDriver: Driver<Bool> { get }
    var showCharactersEmptyStateDriver: Driver<Bool> { get }
}

protocol CharactersViewModelProtocol: ViewModelProtocol {
    var inputs: CharactersViewModelInputs { get }
    var outputs: CharactersViewModelOutputs { get }
}
class CharactersViewModel: CharactersViewModelProtocol, CharactersViewModelInputs {

    var inputs: CharactersViewModelInputs { return self }
    var outputs: CharactersViewModelOutputs { return self }

    var didAppear = PublishSubject<Void>()
    var endOfList = PublishSubject<Void>()
    var characterSelected = PublishSubject<Character>()
    var willDisplayCharacterCell = PublishSubject<IndexPath>()

    var disposeBag = DisposeBag()
    private var getCharactersResult: Observable<Result<CharactersResponse>>
    private var charactersBehaviorRelay = BehaviorRelay<[Character]>(value: [])
    private var getCharactersIsLoadingPublishSubject = PublishSubject<Bool>()

    init(coordinator: CharactersCoordinator, service: CharactersServiceProtocol = CharactersService()) {
        let getCharactersLoading = PublishSubject<Bool>()
        getCharactersIsLoadingPublishSubject = getCharactersLoading
        let characters = BehaviorRelay<[Character]>(value: [])
        charactersBehaviorRelay = characters

        getCharactersResult = Observable.merge(didAppear, willDisplayCharacterCell.filter { $0.row == characters.value.count-1 }.map { _ in return Void() }).flatMap({ _ -> Observable<Result<CharactersResponse>> in
            getCharactersLoading.onNext(true)
            return service.getCharacters(offset: characters.value.count)
        }).share()

        getCharactersResult.map { $0.value?.data.results }.unwrap().bind(onNext: { results in
            characters.accept(characters.value + results)
        }).disposed(by: disposeBag)
//        getCharactersResult.map { $0.error }.unwrap().bind(to: )
        getCharactersResult.subscribe { getCharactersLoading.onNext(false) }.disposed(by: disposeBag)

        characterSelected.subscribe(onNext: { character in
            coordinator.route(path: CharactersPath.details(character: character))
        }).disposed(by: disposeBag)
    }

}

extension CharactersViewModel: CharactersViewModelOutputs {
    var dataSource: Driver<[SectionViewModel<CharacterItemViewModel>]> {
        return charactersBehaviorRelay.map { characters in
            return [SectionViewModel<CharacterItemViewModel>(items: characters.map { character in
                return CharacterItemViewModel(character: character)
            })]
        }.asDriver(onErrorJustReturn: [])
    }

    var showCharactersLoadingStateDriver: Driver<Bool> {
        return getCharactersIsLoadingPublishSubject.map{ $0 }.asDriver(onErrorJustReturn: false)
    }

    var showCharactersEmptyStateDriver: Driver<Bool> {
        return charactersBehaviorRelay.map { $0.isEmpty }.asDriver(onErrorJustReturn: true)
    }
}
