//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    var str = StringFiles()
    var expression = Expression()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != str.plus && elements.last != str.minus && elements.last != str.division && elements.last != str.multiplication
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != str.plus && elements.last != str.minus && elements.last != str.division && elements.last != str.multiplication
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = str.none
    }
    
    @IBAction func acButton(_ sender: Any) {
        textView.text = str.none
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
    func alertMessageMod(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func tappedButton(_ sender: UIButton) {
        if canAddOperator {
            switch sender.tag {
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
            alertMessageMod(title: str.zero, message: str.occuped)
        }
    }
    
    @IBAction func tappedButtonAction(_ sender: UIButton){
        tappedButton(sender)
    }
    
    func alertMessage(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            return alertMessage(title: str.zero, message: str.correct)
        }
        
        guard expressionHaveEnoughElement else {
            return alertMessage(title: str.oups, message: str.new)
        }
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            let result: Double
            switch operand {
            case str.plus: result = left + right
            case str.minus: result = left - right
            case str.multiplication: result = left * right
            case str.division: result = left / right
            default: fatalError(str.unk)
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
        
    }
    
}


