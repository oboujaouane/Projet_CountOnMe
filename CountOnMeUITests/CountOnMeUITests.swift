//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by ousama boujaouane on 02/09/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest

class CountOnMeUITests: XCTestCase {

    // MARK: - Property
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    // Perform a complex operation
    func testGivenIs9MultipliedBy12Plus96DividedBy3Minus4_WhenEqualOperatorButtonTapped_Then136ShouldBeDisplayed() {
        app.buttons["9"].tap()
        app.buttons["×"].tap()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["6"].tap()
        app.buttons["÷"].tap()
        app.buttons["3"].tap()
        app.buttons["-"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()
        
        let currentTextView = app.textViews["currentTextView"]
        XCTAssertEqual(currentTextView.value as! String, "9 × 12 + 96 ÷ 3 - 4 = 136")
    }

}
