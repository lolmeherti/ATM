//
//  TransactionsModel.swift
//  ATM
//
//  Created by Swift Developer on 06.09.22.
//

import Foundation
import SwiftUI

struct TransactionsModel: Identifiable, Hashable{
    var id:String
    var userForeignId:String
    var transactionAmount:Double
    var recipientFirstName:String
    var recipientLastName:String
    var transactionSubject:String
    var transactionType:String
    var transactionDate:Date
}
