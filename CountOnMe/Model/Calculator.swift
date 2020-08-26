//
//  Calculator.swift
//  CountOnMe
//
//  Created by ousama boujaouane on 24/08/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

class Calculator {
    // MARK: - Internal properties
    var currentText = ""
    
    var elements: [String] {
        return currentText.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        isValidExpressionOrOperator()
    }

    // MARK: - Fileprivate properties

    fileprivate  var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    fileprivate var canAddOperator: Bool {
        isValidExpressionOrOperator()
    }

    // check if currentText already contains an operation with a result or no
    fileprivate var expressionHaveResult: Bool {
        return currentText.firstIndex(of: "=") != nil
    }

    // MARK: - Initialization
    init(currentText: String) {
        self.currentText = currentText
    }

    // MARK: - Internal functions
    // Clear calcul
    func clearAll() {
        currentText = "0"
    }

    // Remove last element
    func clearLastEntry() {
        if currentText == "0" {
            return
        }

        if expressionHaveResult {
            if let firstCharacterToTrim = currentText.firstIndex(of: "=") {
                for character in currentText {
                    if let index = currentText.lastIndex(of: character) {
                        if index >= currentText.index(before: firstCharacterToTrim) {
                            currentText.remove(at: index)
                        }
                    }
                }
            } else {
                currentText = "0"
            }
        }

        currentText.remove(at: currentText.index(before: currentText.endIndex))

        if currentText.isEmpty {
            currentText = "0"
        }
    }

    // Add number for calculation
    func addNumber(number: String) {
        if expressionHaveResult {
            currentText = ""
        }
        currentText = currentText == "0" ? number : currentText + number
    }

    // Add operator for calculation
    func addOperator(operator symbol: String) -> Bool {
        guard canAddOperator else {
            return false
        }

        if let lastElement = elements.last, expressionHaveResult {
            currentText = lastElement
        }

        currentText += " \(symbol) "
        return true
    }

    func calculate() -> (validity: Bool, message: String) {
        guard expressionIsCorrect else {
            return (false, "Veuillez entrer une expression correcte.")
        }

        guard expressionHaveEnoughElement else {
            return (false, "Veuillez démarrer un nouveau calcul.")
        }

        guard !expressionHaveResult else {
            if let lastElement = elements.last {
                currentText = lastElement
                return (true, "\(lastElement)")
            }
            return (false, "0")
        }

        var operations = elements
        var result: Float = 0
        var index = 0

        func executeOperation(_ signOperator: SignOperator) {
            if let firstOperand = Float(operations[index-1]), let secondOperand = Float(operations[index+1]) {
                switch signOperator {
                case .addition:
                    result = firstOperand + secondOperand
                case .substraction:
                    result = firstOperand - secondOperand
                case .multiplication:
                    result = firstOperand * secondOperand
                case .division:
                    result = firstOperand / secondOperand
                }
                operations.remove(at: index+1)
                operations.remove(at: index)
                operations.remove(at: index-1)
                operations.insert("\(result)", at: index-1)
                index = 0
            }
        }

        // Iterate over operations while an operator still here
        while index < operations.count - 1 {
            if operations.contains("×") || operations.contains("÷") {
                if operations[index] == "×" {
                    executeOperation(.multiplication)
                } else if operations[index] == "÷" {
                    if let secondOperand = Float(operations[index+1]), secondOperand == 0 {
                        return (false, "Impossible de diviser par 0 !")
                    } else {
                        executeOperation(.division)
                    }
                }
                index += 1
            } else {
                index = 0
                break
            }
        }

        while index < operations.count - 1 {
            if operations[index] == "+" {
                executeOperation(.addition)
            } else if operations[index] == "-" {
                executeOperation(.substraction)
            }
            index += 1
        }

        if let result = operations.first, let floatResult = Float(result) {
            currentText.append(" = \(floatResult.clean)")
        }

        return (true, "")
    }

    // MARK: - Fileprivate functions
    // Check if last element is an operator when equal button is pressed
    fileprivate func isValidExpressionOrOperator() -> Bool {
        return elements.last != "÷" && elements.last != "×" && elements.last != "-" && elements.last != "+"
    }

    // MARK: - Fileprivate enumeration
    fileprivate enum SignOperator {
        case addition, substraction, multiplication, division
    }
}
