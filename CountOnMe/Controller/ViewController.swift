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
    var expression = Expression()
    
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
        if alert.expressionHaveResult {
            textView.text = str.none
        }
        textView.text.append(numberText)
    }
    
    // MARK - Alerts fucntions
    func alertMessage(message: String) {
        let alertVC = UIAlertController(title: str.zero, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: str.ok, style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    func alertOccupied() {
       alertMessage(message: str.occuped)
    }
    func alertCorrect() {
        alertMessage(message: str.correct)
    }
    func alertNew() {
       alertMessage(message: str.new)
    }
    
    // MARK - Button operation function
    @IBAction func tappedButton(_ sender: UIButton) {
        if alert.canAddOperator {
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
       guard alert.expressionIsCorrect else {
           return alertCorrect()
        }
        guard alert.expressionHaveEnoughElement else {
           return alertNew()
        }
        expression.equalButton(textView: textView)
    }
}
