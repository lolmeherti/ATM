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
    
    func logTransfer(userId:String,
                     recipientFirstName:String,
                     recipientLastName:String,
                     transferSubject:String,
                     transferAmount:Double)
    {
        
        let db = Firestore.firestore()
        
        db.collection("transaction_table").addDocument(data:
        [
            "user_foreign_id":userId,
            "transaction_recipient_last_name":recipientLastName,
            "transaction_recipient_first_name":recipientFirstName,
            "transaction_subject":transferSubject,
            "transaction_amount":transferAmount,
            "transaction_type":"Transfer",
            "transaction_date":Date()
        ])
    }
    
    //executes callbacks needed for the transfer to complete
    
    func transferBalance(senderAccountNumber:String, recipientAccountNumber:String, transferAmount:Double, completion: @escaping (Bool) -> Void){
        
        //check if the recipients account number is registered in the database
        let db = Firestore.firestore()
        db.collection("card_table").whereField("card_account_number", isEqualTo: recipientAccountNumber).getDocuments { documents, error in
            for document in documents!.documents {//if the recipient is found in the  database, we loop once. if the recipient is not found, we never loop.
                
                //its okay to have this execute inside the loop, because our account number is always unique and there will only ever be one record
                //we are simply withdrawing the amount out of the current users balance here
                CreditCardViewModel().withdrawFromAccountBalance(accountNumber: senderAccountNumber, withdrawAmount: transferAmount) { unusedNewBalanceFromCompletion in }//as the naming says, we dont need to escape new balance in this case
                
                //then we are depositing the same amount to the recipients account
                CreditCardViewModel().depositToAccountBalance(accountNumber: recipientAccountNumber, depositAmount: transferAmount) { unusedNewBalanceFromCompletion in } //same as above
                
                //we escape true if the transfer succeeded
                completion(true)
            }
        }
        
        //if the transfer fails, it means we havent found the recipient inside our database
        //we escape false in this case
        completion(false)
    }
}
