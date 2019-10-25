//
//  AlertOperator.swift
//  CountOnMe
//
//  Created by stephane verardo on 29/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum AlertError : Error {
    case cannotAddOperator
    case hasNotEnoughElement
    case expresionIsNotCorrect
    case expressionHasNoResult    
}
class AlertOperator {
    var elements = [String()]
    var expressionIsCorrect: Bool {
        return elements.last != plus && elements.last != minus && elements.last != division && elements.last != multiplication
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var canAddOperator: Bool {
        return elements.last != plus && elements.last != minus && elements.last != division &&
            elements.last != multiplication
    }
    var calcul: String {
        return elements.joined(separator: " ")
    }
    func increaseClic() -> Int {
           var numberOfClic = 0
           numberOfClic += 1
           return numberOfClic
       }
    func clearArray() -> [String] {
                if increaseClic() == 1 {
                   if elements.count >= 1 {
                   elements.remove(at: elements.count - 1)
                   }
                   print(elements)
               }
                else if increaseClic() == 2 {
                    elements.removeAll()
                }
                return elements
            }
     func addNumber(_ number: String) {
           if elements.isEmpty {
               elements.append(number)
           } else {
            if elements.last == plus || elements.last == minus || elements.last == division ||
                elements.last == multiplication {
                   elements.append(number)
               } else {
                   var currentNumber = elements.last ?? ""
                   currentNumber.append(number)
                   elements[elements.count-1] = currentNumber
               }
           }
       }
    
    func addOperator (_ op: String) throws{
        guard canAddOperator else {
            throw AlertError.cannotAddOperator
        }
        elements.append(op)
    }
    func computeCalcul() throws {
        var operationsToReduce = elements
        guard expressionIsCorrect else {
            throw AlertError.expresionIsNotCorrect
        }
        guard expressionHaveEnoughElement else {
            throw AlertError.hasNotEnoughElement
        }
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            var result = Double()
            switch operand {
            case plus: result = left + right
            case minus: result = left - right
            case multiplication: result = left * right
            case division: result = left / right
            default: fatalError(unk)
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        elements = operationsToReduce
    }
}
