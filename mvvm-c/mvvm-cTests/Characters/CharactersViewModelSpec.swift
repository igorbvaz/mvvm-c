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

            beforeEach {
                coordinator = CharactersCoordinatorSpy()
                service = CharactersServiceMock()
                viewModel = CharactersViewModel(coordinator: coordinator, service: service)
                scheduler = TestScheduler(initialClock: 0)
                disposeBag = DisposeBag()
            }

            context("when viewDidLoad") {
                beforeEach {
                    scheduler.createColdObservable([.next(10, ())]).bind(to: viewModel.inputs.didLoad).disposed(by: disposeBag)
                }

                it("should showCharactersLoadingState") {
                    let observer = scheduler.createObserver(Bool.self)
                    viewModel.outputs.showCharactersLoadingStateDriver.drive(observer).disposed(by: disposeBag)
                    scheduler.start()
                    expect(observer.events.first?.value.element).to(beTrue())
                }

                it("should call service's getCharacters") {
                    scheduler.start()
                    expect(service.getCharactersCalled).to(beTrue())
                }

                context("when getCharacters succeeds") {
                    beforeEach {
                        service.resultType = .success
                    }

                    it("should not showCharactersLoadingState") {
//                        let observer = scheduler.createObserver(Bool.self)
//                        viewModel.outputs.showCharactersLoadingStateDriver.drive(observer).disposed(by: disposeBag)
//                        scheduler.start()
//                        expect(observer.events).toEventually(containElementSatisfying({ item -> Bool in
//                            print("the item \(item)")
//                            return item.value.element == true
//                        }))
                    }

                    it("should set the dataSource") {
                        let observer = scheduler.createObserver([SectionViewModel<CharacterItemViewModel>].self)
                        viewModel.outputs.dataSource.drive(observer).disposed(by: disposeBag)
                        scheduler.start()
                        expect(observer.events).to(containElementSatisfying({ (item) -> Bool in
                            return item.value.element?.first?.items.first?.character.name == CharactersMock.character.name
                        }))
                    }

                    context("when there are no results") {
                        beforeEach {
                            service.getCharactersResultValue = CharactersMock.zeroCharactersResponse
                        }

                        it("should showEmptyState") {
                            let observer = scheduler.createObserver(Bool.self)
                            viewModel.outputs.showCharactersEmptyStateDriver.drive(observer).disposed(by: disposeBag)
                            scheduler.start()
                            expect(observer.events).to(containElementSatisfying({ (item) -> Bool in
                                return item.value.element == true
                            }))
                        }

                    }

                    context("when there are more than 1 result") {
                        beforeEach {
                            service.getCharactersResultValue = CharactersMock.twoCharactersResponse
                        }
                        it("should not showEmptyState") {
                            let observer = scheduler.createObserver(Bool.self)
                            viewModel.outputs.showCharactersEmptyStateDriver.drive(observer).disposed(by: disposeBag)
                            scheduler.start()
                            expect(observer.events).to(containElementSatisfying({ (item) -> Bool in
                                return item.value.element == false
                            }))
                        }
                    }
                }

                context("when getCharacters faills") {
                    beforeEach {
                        service.resultType = .failure
                    }

                    it("should not showCharactersLoadingState") {
                        let observer = scheduler.createObserver(Bool.self)
                        viewModel.outputs.showCharactersLoadingStateDriver.drive(observer).disposed(by: disposeBag)
                        scheduler.start()
                        expect(observer.events).to(containElementSatisfying({ item -> Bool in
                            return item.value.element == true
                        }))
                    }
                }
            }

            context("when loadNextPage") {
                beforeEach {
                    scheduler.createColdObservable([.next(10, ())]).bind(to: viewModel.inputs.didLoad).disposed(by: disposeBag)
                    scheduler.createColdObservable([.next(20, ())]).bind(to: viewModel.inputs.loadNextPage).disposed(by: disposeBag)
                }

                it("should showCharactersLoadingState") {
                    let observer = scheduler.createObserver(Bool.self)
                    viewModel.outputs.showCharactersLoadingStateDriver.drive(observer).disposed(by: disposeBag)
                    scheduler.start()
                    expect(observer.events).to(containElementSatisfying({ item -> Bool in
                        return item.value.element == true
                    }))
                }

                it("should call service's getCharacters") {
                    scheduler.start()
                    expect(service.getCharactersCalled).to(beTrue())
                }

                context("when getCharacters succeeds") {
                    beforeEach {
                        service.resultType = .success
                    }

                    it("should set the dataSource") {
//                        let observer = scheduler.createObserver([SectionViewModel<CharacterItemViewModel>].self)
//                        viewModel.outputs.dataSource.drive(observer).disposed(by: disposeBag)
//                        scheduler.start()
//                        expect(observer.events).to(containElementSatisfying({ (item) -> Bool in
//                            return item.value.element?.first?.items.first?.character.id == CharactersMock.character.id && item.value.element?.first?.items.count == CharactersMock.charactersResponse.data.results.count
//                        }))
                    }

                    context("when there are no results") {
                        beforeEach {
                            service.getCharactersResultValue = CharactersMock.zeroCharactersResponse
                        }

                        it("should not showEmptyState") {
                            let observer = scheduler.createObserver(Bool.self)
                            viewModel.showCharactersEmptyStateDriver.drive(observer).disposed(by: disposeBag)
                            scheduler.start()
                            expect(observer.events).to(containElementSatisfying({ (item) -> Bool in
                                return item.value.element == true
                            }))
                        }

                    }

                    context("when there are more than 1 result") {
                        beforeEach {
                            service.getCharactersResultValue = CharactersMock.twoCharactersResponse
                        }
                        it("should not showEmptyState") {
                            let observer = scheduler.createObserver(Bool.self)
                            viewModel.outputs.showCharactersEmptyStateDriver.drive(observer).disposed(by: disposeBag)
                            scheduler.start()
                            expect(observer.events).to(containElementSatisfying({ (item) -> Bool in
                                return item.value.element == false
                            }))
                        }
                    }
                }

                context("when getCharacters faills") {
                    // TODO:
                }

            }

            context("when characterSelected") {
                beforeEach {
                    scheduler.createColdObservable([.next(10, CharactersMock.character)]).bind(to: viewModel.inputs.characterSelected).disposed(by: disposeBag)
                }

                it("should go to CharactersDetails") {
                    scheduler.start()
                    expect(coordinator.goToDetails).to(beTrue())
                }
            }
        }
    }
}
