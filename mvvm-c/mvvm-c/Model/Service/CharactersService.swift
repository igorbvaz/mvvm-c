//
//  CharactersService.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift

protocol CharactersServiceProtocol {
    func getCharacters(offset: Int) -> Observable<Result<CharactersResponse>>
}

class CharactersService: Service, CharactersServiceProtocol {
    func getCharacters(offset: Int) -> Observable<Result<CharactersResponse>> {
        return request(endpoint: Endpoints.Characters.getCharacters(offset: offset), method: .get)
    }
}
