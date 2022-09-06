//
//  TransactionsModel.swift
//  ATM
//
//  Created by Swift Developer on 06.09.22.
//

import Foundation
import SwiftUI

struct TransactionsModel: Identifiable{
    var id:String
    var userForeignId:String
    var transactionAmount:Double
    var recipient:String
    var sender:String
    var transactionType:String
    var transactionDate:Date
    
}
