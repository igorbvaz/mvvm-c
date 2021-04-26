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
        let cell = app.tables.element.cells.element(boundBy: 2)
        let tappedCharacterName = cell.staticTexts.element.label
        cell.tap()
        if app.staticTexts[tappedCharacterName].waitForExistence(timeout: 2) {
            app.navigationBars["mvvm_c.CharacterDetailsView"].buttons.firstMatch.tap()
        }
    }

    func test_pagination() {
        let numberOfCells = app.tables.element.cells.count
        app.swipeUp()
        sleep(5)
        wait(for: [XCTestExpectation], timeout: <#T##TimeInterval#>)
        let newNumberOfCells = app.tables.element.cells.count
        XCTAssertGreaterThan(newNumberOfCells, numberOfCells)
    }
}
