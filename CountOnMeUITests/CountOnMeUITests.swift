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

    // Check if alertview is showed with message impossible to divide by 0
    func testGivenIs1DividedBy0_WhenEqualButtonTapped_ThenAlertControllerShouldReturnErrorMessage() {
        app.buttons["1"].tap()
        app.buttons["÷"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()

        // Check if the alert contains the "Impossible de diviser par 0 !" message
        XCTAssert(app.alerts.element.staticTexts["Impossible de diviser par 0 !"].exists)
    }
    
    // Check if AC button replace text with 0
    func testGivenIs1Plus1Equal2_WhenACButtonTapped_Then0ShouldBeDisplayed() {
        app.buttons["AC"].tap()

        let currentTextView = app.textViews["currentTextView"]
        XCTAssertEqual(currentTextView.value as! String, "0")
    }
    
    // Check if C button remove last entry "= 2"
    func testGivenIs1Plus1Equal2_WhenCButtonTapped_Then1Plus1ShouldBeDisplayed() {
        app.buttons["C"].tap()

        let currentTextView = app.textViews["currentTextView"]
        XCTAssertEqual(currentTextView.value as! String, "1 + 1")
    }
    
    // Result 2 divided by 4 to show a decimal number (0.5)
    func testGivenIs1Plus1Equal2_WhenDivideResultBy4_Then0Dot5ShouldBeDisplayed() {
        app.buttons["÷"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()
        
        let currentTextView = app.textViews["currentTextView"]
        XCTAssertEqual(currentTextView.value as! String, "2 ÷ 4 = 0.5")
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
