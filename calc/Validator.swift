//
//  validateArgs.swift
//  calc
//
//  Created by Samuel Polgar on 25/3/2022.
//  Copyright © 2022 UTS. All rights reserved.
//

import Foundation
// Struct contains a boolean operation for each check - we can check which tests fail by checking the structs fail case
struct Validator {
    
    var args: [String]
    var validLength: Bool
    var validOperators: Bool
    var validInts: Bool
    let ops: [String] = ["*","x","X","/","%","+","-"]
    
    init(_ args: [String]){
        self.args = args
        validLength = false
        validOperators = false
        validInts = false
        validateLength()
        validateOperators()
        validateInts()
    }
    
    // Check the array has at least 2 numbers and 1 operator e.g. ["3","x","5"] or 1 number
    mutating func validateLength(){
        if (args.count == 1){
            let answer = args[0]
            if(answer.isInt){
                print("\(Int(answer) ?? 0)")
                exit(1)
            } else {
                ExceptionHandler(errString: "invalid Int").invalidInteger()
            }
        } else if (args.count == 0 || args.count % 2 == 0){
            ExceptionHandler(errString: String(args.count)).invalidLength()
        } else {
            validLength = true;
        }
    }
    
    // Check array odd number is an operator                 i.e. check each middle position & ensure it's xX*/%-+
    mutating func validateOperators(){
        if (args.count >= 3){
            var op: String;
            for i in stride(from: 1, to: args.count-1, by: 2){
                op = args[i]
                if (!ops.contains(op)) {                        //if the operation
                    ExceptionHandler(errString: op).invalidOperator()
                } else {
                    validOperators = true;
                }
            }
        } else {
            validOperators = true;
        }
    }
    // Check array even number is an Int                    i.e. check it's a number and not a Double or a string
    mutating func validateInts(){
        for i in stride(from: 0, to: args.count, by: 2){
            if (!args[i].isInt){
                print(args[i])
                ExceptionHandler(errString: args[i]).invalidInteger()
            }
            validInts = true;
        }
    }
    
    //run this during initialization - we can call this to check if our arguments are valid before creating the calculator
    func isValid() -> Bool{
        if(validLength && validInts && validOperators){
            return true
        } else {
            return false
        }
    }
}

//check if this is a Int
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
