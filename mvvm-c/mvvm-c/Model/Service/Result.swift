//
//  Result.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit

class Result<T> {

    var value: T?
    var error: Error?

    init(value: T?, error: Error?) {
        self.value = value
        self.error = error
    }

    static func success(value: T) -> Result<T> {
        return Result(value: value, error: nil)
    }

    static func failure(error: Error) -> Result<T> {
        return Result(value: nil, error: error)
    }
}
