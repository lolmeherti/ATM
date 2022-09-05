//
//  UserModel.swift
//  ATM
//
//  Created by Swift Developer on 20.07.22.
//

import Foundation
import Firebase

final class UserModel: Identifiable, ObservableObject {
    
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
    
    init(){
        self.id = "DefaultValue"
        self.firstName = "DefaultValue"
        self.lastName = "DefaultValue"
        self.passportId = "DefaultValue"
        self.email = "DefaultValue"
        self.phoneNumber = "DefaultValue"
        self.dateOfBirth = Date()
        self.timestamp = Date()
        self.address = "DefaultValue"
        self.country = "DefaultValue"
        self.role = "DefaultValue"
        self.pinCode = "DefaultValue"
        self.accountNumber = "DefaultValue"
        self.balance = 0
        self.cvc = "DefaultValue"
        self.card_expiration_date = Date()
    }
}

