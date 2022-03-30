//
//  Calculator.swift
//  calc
//
//  Created by Sam Polgar on 26/3/22.
//  Copyright © Polgar Industries
//

import Foundation

class Calculator {
    
    var tempSum: Int
    var op: String
    var lhs: Int
    var rhs: Int
    var opPos: Int
    var leftPos: Int
    var rightPos: Int
    var args: [String] = []
    var filtered: [String] = []
    var tempArr: [String] = []
    
    init(_ args: [String]) {
        
        self.tempSum = 0
        self.lhs = 0
        self.rhs = 0
        self.opPos = 0
        self.leftPos = 0
        self.rightPos = 0
        self.op = ""
        self.args = args
        self.filtered = [""]
        self.tempArr = [""]
        calculatePriority()     //calculate priority operators * / % before regular operators + -
        calculateRegular()      //then calculate regular operators
    }
    
    //loop through args and look for the priority operators. Once found, calculate the left and right numbers and add it back to the array.
    func calculatePriority(){
        for i in stride(from: 1, to: args.count-1, by: 2){
            //assign loop variables
            leftPos = i-1; opPos = i; rightPos = i+1; op = args[i]
            if isPriority(){
                setLeftAndRightInts(args[i-1], args[i+1])
                tempSum = calculate()
                updateArray(tempSum)
            }
        }
        deleteEmptySpacesFromArray()
    }
    //loop through args and look for the regular operators. Once found, calculate the left and right numbers and add it back to the array.
    func calculateRegular(){
        for i in stride(from: 1, to: args.count-1, by: 2){
            //assign loop variables
            leftPos = i-1; rightPos = i+1; opPos = i; op = args[i]
            setLeftAndRightInts(args[i-1], args[i+1])
            tempSum = calculate()
            updateArray(tempSum)
        }
        deleteEmptySpacesFromArray()
    }
    
    //after making the calculation, update the array with "". E.g. ["5","x","3","+","4"] => ["","","15","+","4"]
    func updateArray(_ tempSum: Int){
        args[leftPos] = ""
        args[opPos] = ""
        args[rightPos] = String(tempSum)
    }
    
    //then delete the empty spaces "". E.g. ["5","x","3","+","4"] => ["15","+","4"]
    //use array.filter to prevent out of bounds errors from deleteing an array using array.remove
    func deleteEmptySpacesFromArray(){
        tempArr = args;
        args = tempArr.filter { char in return !char.isEmpty }
    }
    
    //turn string into Int for calculation
    func setLeftAndRightInts(_ leftString: String, _ rightString:String ){
        lhs = Int(leftString) ?? 0
        rhs = Int(rightString) ?? 0
    }
    
    
    func calculate() -> Int {
        switch op {
        case "x", "*", "X":
            return multiply()
        case "/":
            return divide()
        case "%":
            return modulo()
        case "+":
            return lhs + rhs;
        case "-":
            return lhs - rhs;
        default:
            return lhs;
        }
    }
    
    func multiply () -> Int {
        return lhs * rhs
    }
    
    func divide() -> Int {
        if rhs == 0 {
            ExceptionHandler(errString: "\(rhs): the denominator is zero.").divideByZero()
        } else {
            return lhs/rhs
        }
        return 0
    }
    
    func modulo() -> Int {
        if rhs == 0 {
            ExceptionHandler(errString: "\(rhs): the denominator is zero.").moduloByZero()
        } else {
            return lhs%rhs
        }
        return 0
    }
    
    //returns true if priority
    func isPriority() -> Bool {
        switch op {
        case "x", "*", "X", "/", "%":
            return true;
        case "+", "-":
            return false;
        default:
            return false;
        }
    }
}
