//
//  CalculatorTestCase.swift
//  CalculatorTestCase
//
//  Created by Ousama Boujaouane on 26/08/2020.
//  Copyright © 2020 Ousama Boujaouane. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {

    // MARK: - Property
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator(currentText: "")
    }

    func testGivenExpressionIsEmpty_WhenLastElementAddedIsAnOperator_ThenReturnFalse() {
        calculator.currentText = "+"

        XCTAssertFalse(calculator.expressionIsCorrect)
    }

    // Clear all text and replace by 0
    func testGivenIsEmpty_WhenACButtonTapped_Then0ShouldBeDisplayed() {
        calculator.clearAll()

        XCTAssertEqual(calculator.currentText, "0")
    }

    // Clear last entry
    func testGivenIs2Plus2_WhenCButtonTapped_Then2PlusShouldBeDisplayed() {
        calculator.currentText = "2 + 2"

        calculator.clearLastEntry()

        XCTAssertEqual(calculator.currentText, "2 + ")
    }

    func testGivenIs0_WhenMultiplicationOperatorButtonTapped_Then0AndMultiplicationOperatorShouldBeDisplayed() {
        calculator.currentText = "0"

        _ = calculator.addOperator(operator: "×")

        XCTAssertTrue(calculator.currentText == "0 × ")
    }

    // Divided by 0
    func testGivenIs5DividedBy0_WhenIsImpossibleToDivideBooleanCalled_ThenIsImpossibleToDivideBooleanShouldReturnTrue() {
        calculator.currentText = "5 ÷ 0"

        XCTAssertTrue(calculator.isImpossibleToDivide)
    }

    // Add two operators consecutively
    func testGivenIs1Plus_WhenMinusOperatorButtonTapped_ThenCanAddOperatorBooleanShouldReturnFalse() {
        calculator.currentText = "1 + "

        _ = calculator.addOperator(operator: "-")

        XCTAssertFalse(calculator.canAddOperator)
    }

    // Check if expression already have a result
    func testGivenIs1Plus1Equal2_WhenExpressionHaveResultBooleanCalled_ThenExpressionHaveResultBooleanShouldReturnTrue() {
        calculator.currentText = "1 + 1 = 2"

        XCTAssertTrue(calculator.expressionHaveResult)
    }

    // Perform a complex operation
    func testGivenIs9MultipliedBy12Plus96DividedBy3Minus4_WhenEqualOperatorButtonTapped_Then136ResultShouldBeDisplayed() {
        calculator.currentText = "9 × 12 + 96 ÷ 3 - 4"

        _ = calculator.calculate()

        XCTAssertTrue(calculator.currentText == "9 × 12 + 96 ÷ 3 - 4 = 136")
    }

    // Update current text if expression already have a result and clear last entry button touched
    
}
