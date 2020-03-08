//
//  CharactersMock.swift
//  mvvm-cTests
//
//  Created by Igor Vaz on 07/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import Foundation
@testable import mvvm_c

class CharactersMock {
    static var error: Error {
        return NSError(domain: "", code: 1, userInfo: nil)
    }

    static var character: Character {
        return Character(id: 1, name: "Spiderman")
    }

    static var zeroCharactersResponse: CharactersResponse {
        return CharactersResponse(code: 200, data: DataResponse(offset: 0, results: []))
    }

    static var twoCharactersResponse: CharactersResponse {
        return CharactersResponse(code: 200, data: DataResponse(offset: 0, results: [CharactersMock.character, CharactersMock.character]))
    }
}
