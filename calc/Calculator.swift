//
//  Calculator.swift
//  calc
//
//  Created by Sam Polgar on 26/3/22.
//  Copyright © Polgar Industries
//

import Foundation

class Calculator {
    
    var sum = 0;
    var nf = NumberFormatter()
    var op: String = "*"
    var lhs: Int?
    var rhs: Int?
    var args: [String] = []


    init(_ args: [String]) {
        self.args = args
    }
    
    enum ValidationError: Error{
        case divideByZero
        case moduloByZero
    }
    
    func calculatePriority() -> Calculator {
        
        for i in stride(from: 1, to: args.count-1, by: 2){
            op = args[i]
            if isPriority(op){                                      //if it's a priority operator
                
                let leftStringInt = args[i-1]
                let lhs = Int(leftStringInt)
                let rightStringInt = args[i+1]
                let rhs = Int(rightStringInt)

               
                if let lhsSum = lhs, let rhsSum = rhs {
                    sum = calculate(lhsSum, rhsSum, op)                 //get the sum
                    if(args.count>3){
                        args[i+1] = String(sum)                             // put it back into the array at the right position
                        args.remove(at:i)                                   //delete the blank places in the array
                        args.remove(at:i-1)
                    }
                }
            }
        }
        return self                                                     //return the object with a
    }
        
    
    
    func calculateRegular() -> Calculator {                             //
        for i in stride(from: 1, to: args.count-1, by: 2){
            
            op = args[i]
            
            let leftStringInt = args[i-1]
            let lhs = Int(leftStringInt)
            let rightStringInt = args[i+1]
            let rhs = Int(rightStringInt)
            
            if let lhsSum = lhs, let rhsSum = rhs {
                sum = calculate(lhsSum, rhsSum, op)                      //get the sum
                if(args.count>3){
                    args[i+1] = String(sum)                             // put it back into the array at the right position
                    args.remove(at:i)                                   //delete the blank places in the array
                    args.remove(at:i-1)
                // loop again
                }
        }
//        return self
    }
        return self
}
    
    
    
    func calculate(_ lhs: Int,_ rhs: Int,_ op: String) -> Int {
        switch op {
        case "x", "*", "X":
            return multiply(lhs, rhs)
        case "/":
            return tryDivide(lhs, rhs)
        case "%":
            return tryModulo(lhs, rhs)
        case "+":
            return lhs + rhs;
        case "-":
            return lhs - rhs;
        default:
            return lhs;                          // create error reporting for default caser
        }
    }
    
    
    func multiply (_ lhs: Int,_ rhs: Int) -> Int {
        return lhs * rhs
    }
    
    
    //Division
    func tryDivide(_ lhs: Int, _ rhs: Int) -> Int {
        do {
            return try divider(lhs, rhs)
        } catch {
            print("cannot divide by zero \(lhs) / \(rhs)")
            exit(1)
        }
    }
    
    func divider(_ lhs: Int, _ rhs: Int) throws -> Int {
        if rhs == 0 {
            throw ValidationError.divideByZero
        } else {
            print("\(lhs) and \(rhs)")
            return lhs/rhs
        }
    }
    
    func tryModulo(_ lhs: Int, _ rhs: Int) -> Int {
        do {
            return try moduloer(lhs, rhs)
        } catch {
            print("cannot divide by zero \(lhs) % \(rhs)")
            exit(1)
        }
    }
    
    func moduloer(_ lhs: Int, _ rhs: Int) throws -> Int {
        if rhs == 0 {
            throw ValidationError.moduloByZero
        } else {
            print("\(lhs) and \(rhs)")
            return lhs%rhs
        }
    }
    
    func isPriority(_ op: String) -> Bool {
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
