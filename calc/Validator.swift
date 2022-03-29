//
//  validateArgs.swift
//  calc
//
//  Created by Samuel Polgar on 25/3/2022.
//  Copyright © 2022 UTS. All rights reserved.
//

import Foundation
//Todo
// Struct contains a boolean operation for each check - we can check which tests fail by checking the structs fail case
// Check the array has at least 2 numbers and 1 operator e.g. ["3","x","5"]
// Check array odd number is an operator                 i.e. check each middle position & ensure it's xX*/%-+
// Check array even number is an Int                    i.e. check it's a number and not a Double or a string

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
    
    // Check the array has at least 2 numbers and 1 operator e.g. ["3","x","5"]
    mutating func validateLength(){
        let stringInt = args[0]
        if (args.count == 1 && stringInt.isInt) {
            let intInt = Int(stringInt)
            print(intInt!)
        } else if (args.count % 2 == 0) {
            ExceptionHandler(errString: String(args.count)).invalidLength()
        } else {
            validLength = true
        }
    }
    
    // Check array odd number is an operator                 i.e. check each middle position & ensure it's xX*/%-+
    mutating func validateOperators(){
        var op: String;
        for i in stride(from: 1, to: args.count-1, by: 2){
            op = args[i]
            if (!ops.contains(op)) {                        //if the operation isn't in the list of
                ExceptionHandler(errString: op).invalidOperator()
            } else {
                validOperators = true;
            }
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
    
    mutating func validInt(){
        
    }
}

//check if this is a Int
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
