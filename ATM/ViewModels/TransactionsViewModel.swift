//
//  TransactionsViewModel.swift
//  ATM
//
//  Created by Swift Developer on 06.09.22.
//

import Foundation
import Firebase
import SwiftUI

class TransactionsViewModel: Identifiable, ObservableObject {
    @Published var transactions:[TransactionsModel] = []
    
    func logWithdrawal(userId:String, withdrawAmount:Double){
        let db = Firestore.firestore()
        
        db.collection("transaction_table").addDocument(data:
        [
            "user_foreign_id":userId,
            "transaction_amount":withdrawAmount,
            "transaction_type":"Withdrawal",
            "transaction_date":Date()
        ])
    }
    
    func logDeposit(userId:String, depositAmount:Double){
        let db = Firestore.firestore()
        
        db.collection("transaction_table").addDocument(data:
        [
            "user_foreign_id":userId,
            "transaction_amount":depositAmount,
            "transaction_type":"Deposit",
            "transaction_date":Date()
        ])
    }
}
