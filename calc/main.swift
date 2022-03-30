//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

var validArgs = Validator(args);
if (validArgs.isValid()){
    let calc = Calculator(args);
    print("\(Int(calc.args[0]) ?? 0)")
} else {
    ExceptionHandler(errString: "\(args)").invalidArgs()
}
