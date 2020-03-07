//
//  DataResponse.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class DataResponse: Decodable {
    var offset: Int = 0
    var results = [Character]()
}
