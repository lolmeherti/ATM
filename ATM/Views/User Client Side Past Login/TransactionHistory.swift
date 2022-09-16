//
//  TransactionHistory.swift
//  ATM
//
//  Created by Swift Developer on 25.08.22.
//

import SwiftUI

struct TransactionHistory: View {
    @EnvironmentObject var userInstance:UserViewModel
    
    @ObservedObject var transactionViewModel = TransactionsViewModel()
    
    var body: some View {
        //this is a hacky way of calling a function from a view, the variable remains unused
        var fetchData = transactionViewModel.getAllTransactionsByUserId(userId: userInstance.currentUser.id)
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .leading)
                .edgesIgnoringSafeArea(.vertical)
            
            ZStack {
                LinearGradient(colors: [Color("Gold3"), Color("Gold2"), Color("Gold3"), Color("Gold4")],
                               startPoint: .topLeading,
                               endPoint: .bottom)
                .opacity(1)
                .edgesIgnoringSafeArea(.vertical)
                .frame(width: .infinity, height: .infinity)
                ScrollView{
                    Group{
                        VStack(){
                            ForEach(transactionViewModel.transactions) { transaction in
                                TransactionRow(transaction: transaction)
                                    .padding(8)
                                
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct TransactionHistory_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistory()
    }
}
