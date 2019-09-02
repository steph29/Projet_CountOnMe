//
//  Elements.swift
//  CountOnMe
//
//  Created by stephane verardo on 31/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Elements {
    var str = StringFiles()
  
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    init(elements: [String]) {
        self.elements = elements
    }
    
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
}
