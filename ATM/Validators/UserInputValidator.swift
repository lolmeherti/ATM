//
//  UserInputValidator.swift
//  ATM
//
//  Created by Swift Developer on 02.08.22.
//

import Foundation

struct UserInputValidator {
    
    func userNameValidator(name:String) -> Bool{
        
        let nameRegExPattern = "(^[A-Za-z]{4,25})$"
           let userName = NSPredicate(format:"SELF MATCHES %@", nameRegExPattern)
        return userName.evaluate(with: name)
    }
    
    func userEmailValidator(email:String)->Bool{
        do{
            let regexPatternForEmail = "#[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}#"
            let userEmailRegex = try NSRegularExpression(pattern: regexPatternForEmail, options: .caseInsensitive)
            let range = NSRange(location: 0, length: email.count)
            if (userEmailRegex.firstMatch(in: email, options:[], range: range) != nil){
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func userPhoneNumberValidator(phone_number:String) -> Bool{
        do{
            let regexPatternForPhoneNumber = "#([+][0-9]{8,17})$#"
            let userPhoneNumberRegex = try NSRegularExpression(pattern: regexPatternForPhoneNumber, options: .caseInsensitive)
            let range = NSRange(location: 0, length: phone_number.count)
            if (userPhoneNumberRegex.firstMatch(in: phone_number, options:[], range: range) != nil){
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
}


