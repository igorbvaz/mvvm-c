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
    var returnValue: Any!

    func getCharacters(offset: Int) -> Observable<Result<CharactersResponse>> {
        switch resultType {
        case .success:
            return Observable.just(Result.success(value: returnValue as? CharactersResponse ?? CharactersMock.twoCharactersResponse))
        case .failure:
            return Observable.just(Result.failure(error: CharactersMock.error))
        }

    }

}
