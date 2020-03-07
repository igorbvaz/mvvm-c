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
        return request(url: Endpoints.Characters.getCharacters(offset: offset).url, method: .get, parameters: nil)
    }
}
