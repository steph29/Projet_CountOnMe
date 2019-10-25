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
    var alert = AlertOperator()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }

    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = none
    }
    
    @IBAction func acButton(_ sender: Any) {
         textView.text = none
               alert.increaseClic()
               alert.clearArray()
               textView.text = alert.calcul
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
                  alert.addNumber(numberText)
                  textView.text = alert.calcul
    }
    func alertMessageMod(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func tappedButton(_ sender: UIButton) {
        do {
            switch sender.tag {
            case 1:
                try alert.addOperator(plus)
            case 2:
                try alert.addOperator(minus)
            case 3:
                try alert.addOperator(multiplication)
            case 4:
                try alert.addOperator(division)
            default:
                break
            }
            
            textView.text = alert.calcul
        } catch AlertError.cannotAddOperator {
            alertMessageMod(title: noOperator, message: before)
        }
        catch{
            
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
        do {
            try alert.computeCalcul()
            textView.text = alert.calcul
        } catch AlertError.expresionIsNotCorrect {
            alertMessage(title: oups, message: correct)
        } catch AlertError.hasNotEnoughElement {
            alertMessage(title: oups, message: impossible)
        } catch {
            
        }
    }
}
