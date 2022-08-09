//
//  UserModel.swift
//  ATM
//
//  Created by Swift Developer on 20.07.22.
//

import Foundation
import Firebase
	
struct UserModel: Identifiable {
    var id:String
    var first_name:String
    var last_name:String
    var passport_id:String
    var email:String
    var phone_number:String
    var date_of_birth:Date
    var address:String
    var country:String
    var timestamp:Date
    var role:String

    
}
