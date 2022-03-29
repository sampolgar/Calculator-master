//
//  ExceptionHandler.swift
//  calc
//
//  Created by Samuel Polgar on 28/3/2022.
//  Copyright © 2022 UTS. All rights reserved.
//

import Foundation

struct ExceptionHandler {
    
    var errString: String
    
    enum ValidationError: Error{
        case invalidLength
        case invalidInteger
        case invalidOperator
    }
    
    func invalidLength() {
        do {
            throw ValidationError.invalidLength
        }
        catch {
            print("Calculation isn't the right length. length found:   \(errString)")
            exit(1)
        }
    }
    
    func invalidInteger() {
        do {
            throw ValidationError.invalidInteger
        }
        catch {
            print("That's an invalid integer: \(errString)")
            exit(1)
        }
    }
    
    func invalidOperator(){
        do {
            throw ValidationError.invalidOperator
        }
        catch {
            print("That is an invalid operator: \(errString)")
            exit(1)
        }
    }
}
