//
//  UserViewModel.swift
//  ATM
//
//  Created by Swift Developer on 20.07.22.
//

import Foundation
import Firebase
import SwiftUI

class UserViewModel: ObservableObject{
    @Published var insertSuccessful = true
    @Published var currentUser:UserModel = UserModel()
    @Published var isUserLoggedIn:Bool = false
    @Published var forceReload:Bool = false
    
    //Creates a new user
    //Takes array as parameter and expects array keys: first_name, last_name, passport_id, email, phone_number,date_of_birth,address,country, timestamp and role
    func createNewUser(userDetails:[String:Any], completion: @escaping ([String:String]) -> Void) -> Bool{
        
        let db = Firestore.firestore()
        var insertedDocumentReference:DocumentReference? = nil
        var creditCardDetails:[String:String] = ["":""]
        
        insertedDocumentReference = db.collection("user_table").addDocument(data: [
            "user_first_name" : userDetails["first_name"] ?? "" as String,
            "user_last_name" : userDetails["last_name"] ?? "" as String,
            "user_passport_id" : userDetails["passport_id"] ?? "" as String,
            "user_email" : userDetails["email"] ?? "" as String,
            "user_phone_number" : userDetails["phone_number"] ?? "" as String,
            "user_date_of_birth" : userDetails["date_of_birth"] ?? Date() as Date,
            "user_address" : userDetails["address"] ?? "" as String,
            "user_country" : userDetails["country"] ?? "" as String,
            "user_timestamp" : userDetails["timestamp"] ?? Date() as Date,
            "user_role" : userDetails["role"] ?? "" as String
        ]) { error in
            if (error == nil) {
                //---IF THERE ARE NO ERRORS, GENERATE A CREDIT CARD FOR THIS NEWLY SIGNED UP USER---//
                CreditCardViewModel().generateCreditCardForUserById(userId: insertedDocumentReference!.documentID, completion: { creditCardReference in
                    
                    CreditCardViewModel().getCreditCardDetailsById(creditCardId: creditCardReference["credit_card_id"] as! String) { creditCardData in
                        creditCardDetails["card_account_number"] = creditCardData["card_account_number"] as? String ?? ""
                        creditCardDetails["card_pin_code"] = creditCardData["card_pin_code"] as? String ?? ""
                        
                        completion(creditCardDetails)
                    }
                })
            } else {
                self.insertSuccessful.toggle()
            }
        }
        return self.insertSuccessful
    }
    
    //---user_passport_id IS UNIQUE TO EACH USER AND IS USED TO CHECK FOR DUPLICATE USERS IN THE DATABASE---//
    func isUserDuplicate(userPassportID:String, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        
        db.collection("user_table").whereField("user_passport_id", isEqualTo: userPassportID).getDocuments() {(documents, error) in
            
            if(error != nil) {
                print("Error: \(error?.localizedDescription ?? "")")
                completion(false)
            }
            
            for document in documents!.documents{
                let tablePassportId = document.get("user_passport_id")
                if(userPassportID == tablePassportId as! String){
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
    
    //---LOGS USER IN IF THE ACCOUNT NUMBER AND THE PIN CODE MATCH A DATABASE ENTRY---//
    func loginUser(userInputAccountNumber:String, userInputPinCode:String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let dbQuery = db.collection("card_table").whereField("card_account_number", isEqualTo: userInputAccountNumber)
        
        let creditCardValidator = CreditCardValidator()
        
        let accountNumberValid:Bool = creditCardValidator.validateAccountNumber(userInputAccountNumber)
        
        if(accountNumberValid){
            dbQuery.getDocuments() {(documents, error) in
                if(error != nil) {
                    print("Error: \(error?.localizedDescription ?? "")")
                }
                
                var pinCode:String = ""
                
                for document in documents!.documents{
                    pinCode = document.get("card_pin_code") as? String ?? ""
                }
                
                if(userInputPinCode == pinCode){
                    completion(true)
                    return
                } else {
                    completion(false)
                    return
                }
            }
        }
    }
    
    func getUserDetailsByAccountNumber(accountNumber:String, completion: @escaping ([String:Any]) -> Void){
        let db = Firestore.firestore()
        //no parameter validation because the data passed into this function gets validated before the function is used
        let dbQueryForCreditCardInformation = db.collection("card_table").whereField("card_account_number", isEqualTo: accountNumber)
        
        dbQueryForCreditCardInformation.getDocuments() {(documents, error) in
            
            if(error != nil) {
                print("Error: \(error?.localizedDescription ?? "")")
            }
            
            for document in documents!.documents{
                
                let userReference = db.collection("user_table").document(document.get("user_foreign_id") as! String)
                
                userReference.getDocument() {(user, error) in
                    
                    if let user = user, user.exists{
                        let userData = user.data()
                        
                        //converting FIRTimestamp objects to Date objects first
                        let expirationDate = (document.get("card_expiration_date")! as AnyObject).dateValue()
                        let creationTime = (document.get("card_timestamp")! as AnyObject).dateValue()
                        let userDateOfBirth = (userData?["user_date_of_birth"]! as AnyObject).dateValue()
                        
                        let userDetails:[String:Any] = [
                            "Account_Number":document.get("card_account_number") ?? "",
                            "Pin_Code":document.get("card_pin_code") ?? "",
                            "Balance":document.get("card_balance") ?? "",
                            "Cvc":document.get("card_cvc") ?? "",
                            "Expiration_Date":expirationDate,
                            "Creation_Time":creationTime,
                            "User_Foreign_Key":document.get("user_foreign_id") ?? "",
                            "First_Name":userData?["user_first_name"] ?? "",
                            "Last_Name":userData?["user_last_name"] ?? "",
                            "Passport_ID":userData?["user_passport_id"] ?? "",
                            "Email":userData?["user_email"] ?? "",
                            "Phone_Number":userData?["user_phone_number"] ?? "",
                            "Date_Of_Birth":userDateOfBirth,
                            "Address":userData?["user_address"] ?? "",
                            "Country":userData?["user_country"] ?? "",
                            "Role":userData?["user_role"]  ?? "",
                            "userId":document.get("user_foreign_id") ?? ""
                        ]
                        completion(userDetails)
                    }
                }
            }
        }
    }
    
    func setCurrentUserDetails(userDetails:[String:Any]) {
        if(userDetails.keys.contains("Phone_Number")){
            self.currentUser.phoneNumber = userDetails["Phone_Number"] as? String ?? ""
        }

        if(userDetails.keys.contains("Country")){
            self.currentUser.country = userDetails["Country"] as? String ?? ""
        }

        if(userDetails.keys.contains("User_Foreign_Key")){
            self.currentUser.id = userDetails["User_Foreign_Key"] as? String ?? ""
        }

        if(userDetails.keys.contains("Balance")){
            self.currentUser.balance = userDetails["Balance"] as? Double ?? 0
        }

        if(userDetails.keys.contains("Cvc")){
            self.currentUser.cvc = userDetails["Cvc"] as? String ?? ""
        }

        if(userDetails.keys.contains("Expiration_Date")){
            self.currentUser.card_expiration_date = userDetails["Expiration_Date"] as? Date ?? Date()
        }

        if(userDetails.keys.contains("Pin_Code")){
            self.currentUser.pinCode = userDetails["Pin_Code"] as? String ?? ""
        }

        if(userDetails.keys.contains("Address")){
            self.currentUser.address = userDetails["Address"] as? String ?? ""
        }

        if(userDetails.keys.contains("Email")){
            self.currentUser.email = userDetails["Email"] as? String ?? ""
        }

        if(userDetails.keys.contains("Passport_ID")){
            self.currentUser.passportId = userDetails["Passport_ID"] as? String ?? ""
        }

        if(userDetails.keys.contains("Creation_Time")){
            self.currentUser.timestamp = userDetails["Creation_Time"] as? Date ?? Date()
        }

        if(userDetails.keys.contains("Last_Name")){
            self.currentUser.lastName = userDetails["Last_Name"] as? String ?? ""
        }

        if(userDetails.keys.contains("First_Name")){
            self.currentUser.firstName = userDetails["First_Name"] as? String ?? ""
        }

        if(userDetails.keys.contains("Account_Number")){
            self.currentUser.accountNumber = userDetails["Account_Number"] as? String ?? ""
        }

        if(userDetails.keys.contains("Date_Of_Birth")){
            self.currentUser.dateOfBirth = userDetails["Date_Of_Birth"] as? Date ?? Date()
        }

        if(userDetails.keys.contains("Role")){
            self.currentUser.role = userDetails["Role"] as? String ?? ""
        }
    }
}

