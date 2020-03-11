//
//  CharactersServiceMock.swift
//  mvvm-cTests
//
//  Created by Igor Vaz on 08/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift
@testable import mvvm_c

class CharactersServiceMock: CharactersServiceProtocol {

    var resultType: ResultType = .success

    var getCharactersCalled = false
    var getCharactersResultValue: CharactersResponse! = CharactersMock.twoCharactersResponse

    func getCharacters(offset: Int) -> Observable<Result<CharactersResponse>> {
        getCharactersCalled = true
        switch resultType {
        case .success:
            return Observable.just(Result.success(value: getCharactersResultValue))
        case .failure:
            return Observable.just(Result.failure(error: CharactersMock.error))
        }

    }


}
