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

    func testGivenExpressionIsNotCorrect_WhenLastElementIsAnOperator_ThenReturnFalse() {
        calculator.currentText = "+"

        XCTAssertFalse(calculator.expressionIsCorrect)
    }

}
