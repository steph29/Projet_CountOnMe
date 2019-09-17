//
//  AlertOperator.swift
//  CountOnMe
//
//  Created by stephane verardo on 29/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class AlertOperator {
    // Ne fonctionne pas !!!!!!!
    var textView = UITextView()
    var str = StringFiles()
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
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(calculate), name: NSNotification.Name("viewLoaded"), object: nil)
    }
    
    @objc private func calculate(){
        print("La notification est fonctionnelle !! ")
    }   
}
