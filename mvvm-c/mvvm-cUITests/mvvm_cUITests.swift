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
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CheckCharacterDetails() {
        app.launch()

        app.tables.staticTexts["Aaron Stack"].tap()
        XCTAssertTrue(app.staticTexts["Aaron Stack"].exists)
        app.navigationBars["mvvm_c.CharacterDetailsView"].buttons["Back"].tap()

    }
}
