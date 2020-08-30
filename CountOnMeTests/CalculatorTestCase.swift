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

    // Add operator

    func testGivenIs0_WhenMultiplicationOperatorButtonTapped_Then0AndMultiplicationOperatorShouldBeDisplayed() {
        calculator.currentText = "0"

        _ = calculator.addOperator(operator: "×")

        XCTAssertTrue(calculator.currentText == "0 × ")
    }

    func testGivenIs1Plus1Equal2_WhenPlusOperatorButtonTapped_ThenOperatorIsAddedAfterResult() {
        calculator.currentText = "1 + 1 = 2"

        _ = calculator.addOperator(operator: "+")

        XCTAssertTrue(calculator.currentText == "2 + ")
    }

    // Divided by 0
    func testGivenIs5DividedBy0_WhenIsImpossibleToDivideBooleanCalled_ThenIsImpossibleToDivideBooleanShouldReturnTrue() {
        calculator.currentText = "5 ÷ 0"

        XCTAssertTrue(calculator.isImpossibleToDivide)
    }

    func testGivenIs1DividedBy0_WhenEqualButtonTapped_ThenValidityElementOfTupleShouldReturnFalse() {
        calculator.currentText = "1 ÷ 0"

        XCTAssertEqual(calculator.calculate().validity, false)
        XCTAssertEqual(calculator.calculate().message, "Impossible de diviser par 0 !")
    }

    // Add two operators consecutively
    func testGivenIs1Plus_WhenMinusOperatorButtonTapped_ThenCanAddOperatorBooleanShouldReturnFalse() {
        calculator.currentText = "1 + "

        _ = calculator.addOperator(operator: "-")

        XCTAssertFalse(calculator.canAddOperator)
    }

    // Check if expression already has a result
    func testGivenIs1Plus1Equal2_WhenExpressionHasResultBooleanCalled_ThenExpressionHasResultBooleanShouldReturnTrue() {
        calculator.currentText = "1 + 1 = 2"

        XCTAssertTrue(calculator.expressionHasResult)
    }

    // Perform a complex operation
    func testGivenIs9MultipliedBy12Plus96DividedBy3Minus4_WhenEqualOperatorButtonTapped_Then136ResultShouldBeDisplayed() {
        calculator.currentText = "9 × 12 + 96 ÷ 3 - 4"

        _ = calculator.calculate()

        XCTAssertTrue(calculator.currentText == "9 × 12 + 96 ÷ 3 - 4 = 136")
    }

    // Update current text if expression already has a result and clear last entry button touched
    func testGivenAlreadyHasAResult_WhenCButtonTapped_ThenResultShouldBeRemoved() {
        calculator.currentText = "9 × 12 + 96 ÷ 3 - 4 = 136"

        calculator.removeLastEntryOfCurrentText()

        XCTAssertTrue(calculator.currentText == "9 × 12 + 96 ÷ 3 - 4")
    }

    // Remove last spacing of expression
    func testGivenHasExpressionWithSpaceAtEnd_WhenCButtonTapped_ThenExtraSpacingAnd2NumberShouldBeRemoved() {
        calculator.currentText = "9 × 12 "

        calculator.removeLastEntryOfCurrentText()

        XCTAssertTrue(calculator.currentText == "9 × 1")
    }

    // Return if currentText equals to 0
       func testGivenCurrentTextEqualsTo0_WhenCButtonTapped_ThenClearLastEntryFunctionShouldReturn() {
           calculator.currentText = "0"

           calculator.clearLastEntry()

           XCTAssertTrue(calculator.currentText == "0")
       }

    func testGivenCurrentTextEquals9Plus7_WhenEqualButtonTapped_ThenExpressionHasEnoughElementBooleanShouldReturnTrue() {
        calculator.currentText = "9 + 7"

        XCTAssertTrue(calculator.expressionHasEnoughElement)
    }

    func testGivenCurrentTextEquals9Plus_WhenEqualButtonTapped_ThenExpressionHasEnoughElementBooleanShouldReturnFalse() {
         calculator.currentText = "9"

        XCTAssertEqual(calculator.calculate().validity, false)
        XCTAssertEqual(calculator.calculate().message, "Veuillez démarrer un nouveau calcul.")
    }

    func testGivenCurrentTextEquals5Plus_WhenEqualButtonTapped_ThenExpressionIsCorrectBooleanShouldReturnFalse() {
         calculator.currentText = "5 +"

        XCTAssertEqual(calculator.calculate().validity, false)
        XCTAssertEqual(calculator.calculate().message, "Veuillez entrer une expression correcte.")
    }

    func testGivenCurrentTextEquals0_When4NumberButtonTapped_ThenExpressionHasTappedNumberDisplayed() {
        calculator.currentText = "0"

        calculator.addNumber(number: "4")

        XCTAssertEqual(calculator.currentText, "4")
    }

    func testGivenCurrentTextEquals1Plus1Equals2_WhenExpressionHasAlreadyAResult_ThenExpressionIsEmpty() {
        calculator.currentText = "1 + 1 = 2"

        calculator.emptyCurrentTextIfExpressionHasResult()

        XCTAssertEqual(calculator.currentText, "")
    }

    func testGivenCurrentTextEquals1Plus1Equals2_WhenEqualButtonTapped_ThenExpressionShouldDisplay2() {
        calculator.currentText = "1 + 1 = 2"

        _ = calculator.calculate()

        XCTAssertEqual(calculator.currentText, "2")
    }

}
