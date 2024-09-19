//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation


func main() {
    let args = Array(CommandLine.arguments.dropFirst()) 
    let calculator = Calculator()

    do {
        let result = try calculator.calculate(args)
        print(result)
    } catch let error as CalculatorError {
        switch error {
        case .invalidInput:
            print("Invalid input")
        case .divisionByZero:
            print("Division by zero")
        case .outOfBounds:
            print("Out of bounds")
        }
        exit(1)
    } catch {
        print("Unexpected error")
        exit(1)
    }
}


// Call the main function
main()

