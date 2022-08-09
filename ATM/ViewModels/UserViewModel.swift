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
    @Published var users: [UserModel] = []
    
    //Creates a new user
    //Takes array as parameter and expects array keys: first_name, last_name, passport_id, email, phone_number,date_of_birth,address,country, timestamp and role
    func createNewUser(userDetails:[String:Any]) -> Bool{
        
        let db = Firestore.firestore()
        
        db.collection("user_table").addDocument(data: [
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
                self.getAllUsers()
            } else {
                self.insertSuccessful = false
            }
        }
        return self.insertSuccessful
    }
    
    public func getAllUsers(){
        
        let db = Firestore.firestore()
        
        db.collection("user_table").getDocuments{ userTableContent, error in
            if(error == nil) {
                if let userTableContent = userTableContent {
                    DispatchQueue.main.async {
                        self.users = userTableContent.documents.map { users in
                            return UserModel(
                                id: users.documentID,
                                first_name: users["user_first_name"] as? String ?? "",
                                last_name: users["user_last_name"] as? String ?? "",
                                passport_id: users["user_passport_id"] as? String ?? "",
                                email: users["user_email"] as? String ?? "",
                                phone_number: users["user_phone_number"] as? String ?? "",
                                date_of_birth: users["user_date_of_birth"] as? Date ?? Date(),
                                address: users["user_address"] as? String ?? "",
                                country: users["user_country"] as? String ?? "",
                                timestamp: users["user_timestamp"] as? Date ?? Date(),
                                role: users["user_role"] as? String ?? ""
                            )
                        }
                    }
                }
            }
        }
    }
    
    //---PASSPORT_ID IS UNIQUE TO EACH USER AND IS USED TO CHECK FOR DUPLICATE USERS IN THE DATABASE---//
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
    
    
    public func loginUser(accountNumber:String, pinCode:String) -> Bool{
        
        let creditCardValidator = CreditCardValidator()
        
        let accountNumberValid:Bool = creditCardValidator.validateAccountNumber(accountNumber)
        
        if(accountNumberValid){
            //TODO
            //missing comparison code to database
            return true
        }
        return false
    }
}
