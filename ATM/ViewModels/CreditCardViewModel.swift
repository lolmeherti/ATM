//
//  CreditCardViewModel.swift
//  ATM
//
//  Created by Swift Developer on 04.08.22.
//

import Foundation
import Firebase
import SwiftUI

class CreditCardViewModel{
    let signUpBonusBalance:Double = 50.0
    
    
    //---GENERATES CREDIT CARD DETAILS FOR A FRESHLY SIGNED UP USER---//
    func generateCreditCardForUserById(userId:String, completion: @escaping ([String:Any]) -> Void) {
        let db = Firestore.firestore()
        
        var creditCardReference:DocumentReference? = nil
        var creditCardDetails:[String:Any] = [:]
        
        creditCardReference = db.collection("card_table").addDocument(data: [
            "card_account_number":generateCreditCardAccountNumber(),
            "card_pin_code":generatePinCode(),
            "card_balance":signUpBonusBalance, //SIGN UP BONUS
            "card_cvc":generateCvc(),
            "card_expiration_date": generateExpirationDate() ?? Date(),//coalescing safety measure never comes into play
            "card_timestamp":Date(),
            "user_foreign_id":userId
        ]) { error in
            if(error == nil) {
                creditCardDetails = ["credit_card_id":creditCardReference?.documentID ?? ""]
                completion(creditCardDetails)
            } else {
                print("Error: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    //---GENERATES CREDIT CARD ACCOUNT NUMBER---//
    func generateCreditCardAccountNumber() -> String{
        
        var accountNumber:[String] = []
        
        for _ in 1...4 {
            accountNumber.append(String(Int.random(in: 1000..<10000)))
        }
        
        let accountNumberToString:String = accountNumber.joined(separator: "-")
        
        return accountNumberToString
    }
    
    //---WHY THIS IS A SEPARATE FUNCTION? THIS FUNCTION CAN GET MORE COMPLEX WITH TIME AND EVENTUALLY WILL HAVE TO BE ISOLATED---//
    func generatePinCode() -> String{
        return String(Int.random(in: 1000..<10000))
    }
    
    func generateCvc() -> String{
        return String(Int.random(in: 100..<1000))
    }
    
    func getCreditCardDetailsById(creditCardId:String, completion: @escaping ([String:Any]) -> Void){
        let db = Firestore.firestore()
        
        let docRef = db.collection("card_table").document(creditCardId)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                completion(data ?? ["":""])
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func generateExpirationDate() -> Date? {
        //the calendar will always deliver the correct year back. ignore coalescing, its a safety measure that never comes into play
        let expirationYear = (Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year ?? 2050) + 2
        let month = Calendar(identifier: .gregorian).dateComponents([.month], from: .now).month ?? 1
        let day = Calendar(identifier: .gregorian).dateComponents([.day], from: .now).day ?? 1
        
        return Date.from(year: expirationYear, month: month, day: day) ?? nil
    }
}
