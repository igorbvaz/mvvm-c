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
    var didLoad: PublishSubject<Void> { get }
    var loadNextPage: PublishSubject<Void> { get }
    var characterSelected: PublishSubject<Character> { get }
}

protocol CharactersViewModelOutputs {
    var dataSource: Driver<[SectionViewModel<CharacterItemViewModel>]> { get }
    var showCharactersLoadingStateDriver: Driver<Bool> { get }
    var showCharactersEmptyStateDriver: Driver<Bool> { get }
    var errorDriver: Driver<String> { get }
}

protocol CharactersViewModelProtocol: ViewModelProtocol {
    var inputs: CharactersViewModelInputs { get }
    var outputs: CharactersViewModelOutputs { get }
}
class CharactersViewModel: CharactersViewModelProtocol, CharactersViewModelInputs {

    var inputs: CharactersViewModelInputs { return self }
    var outputs: CharactersViewModelOutputs { return self }

    var didLoad = PublishSubject<Void>()
    var loadNextPage = PublishSubject<Void>()
    var characterSelected = PublishSubject<Character>()

    var disposeBag = DisposeBag()
    private var getCharactersResult: Observable<Result<CharactersResponse>>
    private var charactersBehaviorRelay = BehaviorRelay<[Character]>(value: [])
    private var getCharactersIsLoadingPublishSubject = PublishSubject<Bool>()

    init(coordinator: CharactersCoordinatorProtocol, service: CharactersServiceProtocol = CharactersService()) {
        let getCharactersLoading = PublishSubject<Bool>()
        getCharactersIsLoadingPublishSubject = getCharactersLoading
        let characters = BehaviorRelay<[Character]>(value: [])
        charactersBehaviorRelay = characters

        getCharactersResult = Observable.merge(didLoad, loadNextPage).flatMapLatest({ _ -> Observable<Result<CharactersResponse>> in
            getCharactersLoading.onNext(true)
            return service.getCharacters(offset: characters.value.count)
        }).share()

        getCharactersResult.map { $0.value?.data.results }.unwrap().bind(onNext: { results in
            characters.accept(characters.value + results)
        }).disposed(by: disposeBag)

        getCharactersResult.bind(onNext: { _ in
            getCharactersLoading.onNext(false)
        }).disposed(by: disposeBag)

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
        return getCharactersIsLoadingPublishSubject.map { $0 }.asDriver(onErrorJustReturn: false)
    }

    var showCharactersEmptyStateDriver: Driver<Bool> {
        return charactersBehaviorRelay.map { $0.isEmpty }.asDriver(onErrorJustReturn: true)
    }

    var errorDriver: Driver<String> {
        return getCharactersResult.map { ($0.error?.asAFError?.errorDescription ?? "") }.asDriver(onErrorJustReturn: "")
    }
}
