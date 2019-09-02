//
//  Expression.swift
//  CountOnMe
//
//  Created by stephane verardo on 02/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class Expression {
    var str = StringFiles()
    
    
    func equalButton(textView: UITextView) {
    var operationsToReduce = elements
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
        case str.multiplication:
            result = left * right
        case str.division:
            result - left / right
        default: fatalError(str.unk)
    }
    operationsToReduce = Array(operationsToReduce.dropFirst(3))
    operationsToReduce.insert("\(result)", at: 0)
    }
    textView.text.append(" = \(operationsToReduce.first!)")
}
}
