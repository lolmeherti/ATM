//
//  UserModel.swift
//  ATM
//
//  Created by Swift Developer on 20.07.22.
//

import Foundation
import Firebase

class UserModel: Identifiable, ObservableObject {
    
    @Published var id:String
    @Published var firstName:String
    @Published var lastName:String
    @Published var passportId:String
    @Published var email:String
    @Published var phoneNumber:String
    @Published var dateOfBirth:Date
    @Published var address:String
    @Published var country:String
    @Published var role:String
    @Published var pinCode:String
    @Published var accountNumber:String
    @Published var balance:Double
    @Published var cvc:String
    @Published var card_expiration_date:Date
    @Published var timestamp:Date
    
    init(id:String,
         firstName:String,
         lastName:String,
         passportId:String,
         email:String,
         phoneNumber:String,
         dateOfBirth:Date,
         timestamp:Date,
         address:String,
         country:String,
         role:String,
         pinCode:String,
         accountNumber:String,
         balance:Double,
         cvc:String,
         card_expiration_date:Date
    ){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.passportId = passportId
        self.email = email
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.timestamp = timestamp
        self.address = address
        self.country = country
        self.role = role
        self.pinCode = pinCode
        self.accountNumber = accountNumber
        self.balance = balance
        self.cvc = cvc
        self.card_expiration_date = card_expiration_date
    }
}

