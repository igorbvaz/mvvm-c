//
//  CharactersResponse.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class CharactersResponse: Decodable {
    var code: Int
    var data = DataResponse()
}
