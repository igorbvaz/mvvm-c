//
//  mvvm_cUITests.swift
//  mvvm-cUITests
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import XCTest

class mvvm_cUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CheckCharacterDetails() {
        app.tables.element.cells.element(boundBy: 2).tap()
        app.navigationBars["mvvm_c.CharacterDetailsView"].buttons.firstMatch.tap()
    }
}
