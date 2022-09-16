//
//  TransactionRow.swift
//  ATM
//
//  Created by Swift Developer on 14.09.22.
//

import SwiftUI

struct TransactionRow: View {
    
    @EnvironmentObject var userInstance:UserViewModel
    
    var transaction:TransactionsModel
    
    var body: some View {
        HStack(spacing:20) {
            //MARK: transaction category icons
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("DarkColorGradient").opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    if(transaction.transactionType == "Transfer") {
                        Image(systemName: "arrow.left.arrow.right")
                    } else if (transaction.transactionType == "Withdrawal") {
                        Image(systemName: "arrowshape.turn.up.backward.fill")
                    } else if (transaction.transactionType == "Deposit") {
                        Image(systemName: "arrowshape.turn.up.forward.fill")
                    } else {
                        Image(systemName: "hand.tap.fill")
                    }
                }
            
            
            //MARK: transaction subject
            VStack(alignment: .leading, spacing: 6){
                Text(transaction.transactionSubject)
                    .foregroundColor(.darkColorGradient)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                
                //MARK: transaction category
                Text(transaction.transactionType)
                    .foregroundColor(.darkColorGradient)
                    .font(.footnote)
                    .opacity(0.9)
                    .lineLimit(1)
                
                
                //MARK: transaction date
                Text(transaction.transactionDate, format: .dateTime.year().month().day())
                    .foregroundColor(.darkColorGradient)
                    .font(.footnote)
                    .opacity(0.8)
                
            }
            
            Spacer()
            
            //MARK: transaction amount
            Text(checkIfValuePositiveOrNegative(transactionAmount: transaction.transactionAmount), format: .currency(code:"USD"))
                .bold()
                .foregroundColor(.darkColorGradient) //MARK: shorthand if statement to show different colors for different transaction types
        }
        .padding([.top,.bottom], 8)
    }
    
    func checkIfValuePositiveOrNegative(transactionAmount:Double) -> Double{
        //MARK: appearance based on operation of transaction type
        if(transaction.transactionType == "Withdrawal" || (transaction.transactionType == "Transfer" && userInstance.currentUser.id == transaction.userForeignId)) {
            return -transactionAmount
        }
        return transactionAmount
    }
}

//struct TransactionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionRow(transaction: TransactionsViewModel())
//    }
//}
