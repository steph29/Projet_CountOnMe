//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var textView: UITextView!
    var alert = AlertOperator()
    var str = StringFiles()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != str.plus && elements.last != str.minus
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var canAddOperator: Bool {
        return elements.last != str.plus && elements.last != str.minus
    }// Rajouter / et x
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    // A refractoriser!!!!!
    func alertOccupied() {
        let alertVC = UIAlertController(title: str.zero, message: str.occuped, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: str.ok, style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    func alertCorrect() {
        let alertVC = UIAlertController(title: str.zero, message: str.correct, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: str.ok, style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    func alertNew() {
        let alertVC = UIAlertController(title: str.zero, message: str.new, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: str.ok, style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        if canAddOperator {
            let operand = UIButton()
            switch operand.tag {
            case 1:
                textView.text.append(" " + str.plus + " ")
            case 2:
                textView.text.append(" " + str.minus + " ")
            case 3:
                textView.text.append(" " + str.division + " ")
            case 4:
                textView.text.append(" " + str.multiplication + " ")
            default:
                break
            }
        } else {
           alertOccupied()
        }
    }
   
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
       guard expressionIsCorrect else {
           return alertCorrect()
        }
        guard expressionHaveEnoughElement else {
           return alertNew()
        }
    // Create local copy of operations
    /*    var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            let result: Int
            switch operand {
            case str.plus:
                result = left + right
            case str.minus:
                result = left - right
            default: fatalError(str.unk)
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        textView.text.append(" = \(operationsToReduce.first!)") */
    }
}
