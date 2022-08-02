//
//  CreditCardValidator.swift
//  ATM
//
//  Created by Swift Developer on 22.07.22.
//

import Foundation
import SwiftUI

//configurations for credit card format
let amountOfDigitsInAccountNumberCountingHyphens = 19
let amountOfDigitsInAccountNumber = 16

struct CreditCardValidator {

    //this function will check whether the account number is a valid one
    //returns true if the account is valid, returns false if it isnt
    //makes sure the user-input is numbers only
    //makes sure the user-input is the correct length
    public func validateAccountNumber(_ accountNumber: String) -> Bool {
        
        let sanitizedAccountNumber = accountNumber.digits
        
        if(sanitizedAccountNumber.count <= amountOfDigitsInAccountNumberCountingHyphens && sanitizedAccountNumber.count >= amountOfDigitsInAccountNumber) {
            for (_, number) in sanitizedAccountNumber.enumerated() {
                
                if(number.isNumber) {
                    
                    return true
                }
            }
        }
        return false
    }
}

