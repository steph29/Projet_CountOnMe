//
//  Operator.swift
//  CountOnMe
//
//  Created by stephane verardo on 21/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Operator {
    var operate = Operator()
    var str = StringFiles()
    var element = Elements(elements: <#T##[String]#>)
    
    public func Operate() {
      // Create local copy of operations
        var operationsToReduce = element
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            let result: Double
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
        textView.text.append(" = \(operationsToReduce.first!)")
    }
}
