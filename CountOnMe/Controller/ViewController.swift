//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Property
    lazy var calculator = Calculator(currentText: textView.text)

    // MARK: - View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }

        calculator.addNumber(number: numberText)
        textView.text = calculator.currentText
        textView.scrollToBottom()
    }

    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        calculator.clearAll()
        textView.text = calculator.currentText
    }

    @IBAction func tappedClearLastEntryButton(_ sender: UIButton) {
        calculator.clearLastEntry()
        textView.text = calculator.currentText
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let textOperator = sender.title(for: .normal) else {
            return
        }

        guard calculator.addOperator(operator: textOperator) else {
            return presentAlert(with: "Un opérateur a déjà été ajouté.")
        }

        textView.text = calculator.currentText
        textView.scrollToBottom()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let resultStatus = calculator.calculate()

        guard  resultStatus.validity else {
            return presentAlert(with: resultStatus.message)
        }

        textView.text = calculator.currentText
        textView.scrollToBottom()
    }

    // MARK: - Fileprivate function
    fileprivate func presentAlert(with message: String) {
        let alertController = UIAlertController(title: "Erreur",
                                        message: message,
                                        preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
