//
//  Calculator.swift
//  calc
//
//  Created by Yeanhee Park on 20/3/24.
//  Copyright © 2020 UTS. All rights reserved.
//


import Foundation

enum CalculatorError: Error {
    case invalidInput
    case divisionByZero
    case outOfBounds
}

class Calculator {
    
    // For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0;
    
    
    func add(_ no1: Int, _ no2: Int) -> Int {
        return no1 + no2;
    }
    
    // Perform Subtraction
    func subtract(_ no1: Int, _ no2: Int) -> Int {
        return no1 - no2;
    }
    
    // Perform Multiplication
    func multiply(_ no1: Int, _ no2: Int) -> Int {
        return no1 * no2;
    }
    
    // Perform Division
    func divide(_ no1: Int, _ no2: Int) throws -> Int {
        guard no2 != 0 else {
            throw CalculatorError.divisionByZero
        }
        return no1 / no2;
    }
    
    // Perform Modulus
    func modulus(_ no1: Int, _ no2: Int) throws -> Int {
        guard no2 != 0 else {
            throw CalculatorError.divisionByZero
        }
        return no1 % no2;
    }
    
    // Calculate in the form of [number, operator...]
    
    func calculate(_ args: [String]) throws -> Int {
        guard args.count % 2 == 1 else {
            throw CalculatorError.invalidInput
        }
        
        // Separate numbers and operators into two arrays
        var numbers = [Int]()
        var operators = [Character]()
        for (index, arg) in args.enumerated() {
            if index % 2 == 0 {
                guard let number = Int(arg) else {
                    throw CalculatorError.invalidInput
                }
                numbers.append(number)
            } else {
                guard arg.count == 1, let op = arg.first, "+-x/%".contains(op) else {
                    throw CalculatorError.invalidInput
                }
                operators.append(op)
            }
        }
        
        // Perform multiplication and division first
        var index = 0
        while index < operators.count {
            if operators[index] == "x" || operators[index] == "/" || operators[index] == "%" {
                let result: Int
                switch operators[index] {
                case "x":
                    result = numbers[index] * numbers[index + 1]
                case "/":
                    if numbers[index + 1] == 0 {
                        throw CalculatorError.divisionByZero
                    }
                    result = numbers[index] / numbers[index + 1]
                case "%":
                    if numbers[index + 1] == 0 {
                        throw CalculatorError.divisionByZero
                    }
                    result = numbers[index] % numbers[index + 1]
                default:
                    fatalError("Invalid operator")
                }
                numbers[index] = result
                numbers.remove(at: index + 1)
                operators.remove(at: index)
            } else {
                index += 1
            }
        }
        
        // Perform addition and subtraction
        var result = numbers[0]
        for (index, op) in operators.enumerated() {
            switch op {
            case "+":
                result = result + numbers[index + 1]
            case "-":
                result = result - numbers[index + 1]
            default:
                fatalError("Invalid operator")
            }
        }

        return result
    }

}





