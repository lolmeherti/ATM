//
//  CreditCardValidator.swift
//  ATM
//
//  Created by Swift Developer on 22.07.22.
//

import Foundation
import SwiftUI

//configurations for credit card format
let amountOfDigitsInAccountNumber = 16
let amountOfDigitsInPinCode = 4
let pinCodeMinimumValue = 1000
let pinCodeMaximumValue = 9999

struct CreditCardValidator {

    //this function will check whether the account number is a valid one
    //returns true if the account is valid, returns false if it isnt
    //makes sure the user-input is numbers only
    //makes sure the user-input is the correct length
    public func validateAccountNumber(_ accountNumber: String) -> Bool {
        
        let sanitizedAccountNumber = accountNumber.digits
        
        if(sanitizedAccountNumber.count == amountOfDigitsInAccountNumber) {
            for (_, number) in sanitizedAccountNumber.enumerated() {
                
                if(number.isNumber) {
                    
                    return true
                }
            }
        }
        return false
    }
    
    public func validatePinCode(_ pinCode: String) -> Bool {
        let sanitizedPinCode: Int = Int(pinCode.digits) ?? 0
        
        if(sanitizedPinCode >= pinCodeMinimumValue && sanitizedPinCode <= pinCodeMaximumValue) {
            return true
        }
        return false
    }
}

