//
//  CharactersViewModelSpec.swift
//  mvvm-cTests
//
//  Created by Igor Vaz on 07/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import mvvm_c

class CharactersViewModelSpec: QuickSpec {
    override func spec() {
        describe("Characters ViewModel") {

            var coordinator: CharactersCoordinatorSpy!
            var service: CharactersServiceMock!
            var viewModel: CharactersViewModel!

            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!

            var showCharactersLoadingStateObserver: TestableObserver<Bool>!
            var dataSourceObserver: TestableObserver<[SectionViewModel<CharacterItemViewModel>]>!

            beforeEach {
                coordinator = CharactersCoordinatorSpy()
                service = CharactersServiceMock()
                viewModel = CharactersViewModel(coordinator: coordinator, service: service)
                scheduler = TestScheduler(initialClock: 0)
                disposeBag = DisposeBag()

                showCharactersLoadingStateObserver = scheduler.createObserver(Bool.self)
                dataSourceObserver = scheduler.createObserver([SectionViewModel<CharacterItemViewModel>].self)

                viewModel.outputs.showCharactersLoadingStateDriver
                    .drive(showCharactersLoadingStateObserver)
                    .disposed(by: disposeBag)

                viewModel.outputs.dataSource
                    .drive(dataSourceObserver)
                    .disposed(by: disposeBag)
            }

            context("when viewDidLoad") {
                beforeEach {
                    scheduler.createColdObservable([.next(10, ())])
                        .bind(to: viewModel.inputs.didLoad)
                        .disposed(by: disposeBag)

                    scheduler.start()
                }

                it("should show loading state") {
                    expect(showCharactersLoadingStateObserver.events).to(containElementSatisfying({ item -> Bool in
                        return item.value.element == true && item.time == 10
                    }))
                }

                context("and service's getCharacters returns success") {
                    beforeEach {
                        service.resultType = .success
                        scheduler.start()
                    }

                    it("should output dataSource") {
                        expect(dataSourceObserver.events).to(containElementSatisfying({ item -> Bool in
                            return item.value.element?.first?.items.count == CharactersMock.twoCharactersResponse.data.results.count && item.time == 10
                        }))
                    }

                    it("should show loading state") {
                        expect(showCharactersLoadingStateObserver.events).to(containElementSatisfying({ item -> Bool in
                            return item.value.element == false && item.time == 10
                        }))
                    }

                }
            }

            context("when loadNextPage") {
                beforeEach {
                    scheduler.createColdObservable([.next(10, ())])
                        .bind(to: viewModel.inputs.didLoad)
                        .disposed(by: disposeBag)

                    scheduler.createColdObservable([.next(20, ())])
                        .bind(to: viewModel.inputs.loadNextPage)
                        .disposed(by: disposeBag)

                    scheduler.start()
                }

                it("should show loading state") {
                    expect(showCharactersLoadingStateObserver.events).to(containElementSatisfying({ item -> Bool in
                        return item.value.element == true && item.time == 20
                    }))
                }

                context(<#T##description: String!##String!#>, <#T##closure: QCKDSLEmptyBlock!##QCKDSLEmptyBlock!##() -> Void#>)
//                it("should call service's getCharacters") {
//                    expect(service.getCharactersCalled).to(beTrue())
//                }
            }

            context("when user selects a character") {
                beforeEach {
                    scheduler.createColdObservable([.next(10, CharactersMock.character)])
                        .bind(to: viewModel.inputs.characterSelected)
                        .disposed(by: disposeBag)

                    scheduler.start()
                }

                it("should go to CharactersDetails") {
                    expect(coordinator.goToDetails).to(beTrue())
                }
            }

        }
    }
}
