//
//  RecentTransactionsView.swift
//  ATM
//
//  Created by Swift Developer on 14.09.22.
//

import SwiftUI
import Firebase

struct RecentTransactionsView: View {
    
    @EnvironmentObject var userInstance:UserViewModel
    
    @ObservedObject var transactionViewModel = TransactionsViewModel()
    
    var body: some View {
        
        //this is a hacky way of calling a function from a view, the variable remains unused
        var fetchData = transactionViewModel.getAllTransactionsByUserId(userId: userInstance.currentUser.id)
        
        VStack{
            HStack {
                //MARK: header title
                Text("Recent Transactions")
                    .foregroundColor(.darkColorGradient)
                    .bold()
                
                Spacer()
                
                //MARK: header link
                NavigationLink{
                    TransactionHistory()
                } label: {
                    HStack(spacing: 4) {
                        Text("")
                        Image(systemName: "")
                    }
                    .foregroundColor(.darkColorGradient)
                }
            }
            .padding(.top)
            
            //MARK: show the list of transactions
                ForEach(transactionViewModel.transactions.prefix(4)) { transaction in
                    TransactionRow(transaction: transaction)
                    
                    Divider()
                }
        }
        .padding()
        .background(LinearGradient(colors: [Color("Gold3"), Color("Gold2"), Color("Gold3"), Color("Gold4")],startPoint: .topLeading,endPoint: .bottom)
            .opacity(1)
            .edgesIgnoringSafeArea(.vertical)
            .frame(width: 350)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .shadow(color: Color.black.opacity(0.8), radius: 15, x: 0, y: 10))
            .offset(x: 0, y: 100)
            .padding(8)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("DarkColorGradient").opacity(0.3), radius: 10, x:0, y:5)
    }
}

struct RecentTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentTransactionsView()
    }
}
