//
//  CredCardModel.swift
//  ATM
//
//  Created by Swift Developer on 29.07.22.
//

import Foundation
import Firebase

struct CreditCardModel: Identifiable {
    var id:String
    var foreign_id:String
    var accountNumber:Int
    var pin_code:Int
    var cvc:Int
    var transactions:String
    var balance:Float
    var expiration_date:Date
    var timestamp:Date
}
