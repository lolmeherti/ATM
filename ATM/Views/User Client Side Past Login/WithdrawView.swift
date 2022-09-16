//
//  WithdrawView.swift
//  ATM
//
//  Created by Swift Developer on 25.08.22.
//

import SwiftUI

struct WithdrawView: View {
    @EnvironmentObject var userInstance:UserViewModel
    @State var withdrawAmount:Double = 0
    @State var showBalance:Double = 0
    @State var showWithdrawAlert:Bool = false
    @State var withdrawAlertTitle:String = "INSUFFICIENT FUNDS\n"
    @State var withdrawAlertString:String = "Your withdraw amount is greater than your available balance.\n"
    @State var withdrawAlertButtonText:String = "TRY AGAIN"
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .leading)
                .edgesIgnoringSafeArea(.vertical)
            
            ScrollView{
                VStack(alignment: .center, spacing: 25){
                    Text("Your current balance:")
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .offset(x: 0, y: 80)
                    
                    Text("$\(showBalance > 0 ? showBalance : userInstance.currentUser.balance, specifier: "%.2f")")
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("LighterYellow"))
                        .multilineTextAlignment(.center)
                        .offset(x: 0, y: 60)
                    
                    Spacer()
                    Text("Amount to withdraw")
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .offset(x: 0, y: 105)
                    
                    
                    TextField("Amount to withdraw", value: $withdrawAmount, format:.number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 20)
                        .offset(x: 0, y: 95)
                        .keyboardType(.decimalPad)
                    
                    Spacer()
                    
                    Button{
                        
                        if(userInstance.currentUser.balance > withdrawAmount &&
                           withdrawAmount > 0){
                            CreditCardViewModel().withdrawFromAccountBalance(accountNumber: userInstance.currentUser.accountNumber, withdrawAmount: withdrawAmount){ currentBalance in
                                //instantly updates the current balance to match the balance after withdrawal
                                showBalance = currentBalance
                                //logs this transaction in the database
                                TransactionsViewModel().logWithdrawal(userId: userInstance.currentUser.id, withdrawAmount: withdrawAmount)
                            }
                        } else {
                            showWithdrawAlert = true
                        }
                        
                    } label: {
                        Text("Withdraw")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .alert(isPresented: $showWithdrawAlert, content: {
                        return Alert(title: Text(withdrawAlertTitle), message: Text(withdrawAlertString), dismissButton: .default(Text(withdrawAlertButtonText), action: {
                            //---RESETS ERROR MESSAGE WHEN "TRY AGAIN"---//
                            self.withdrawAlertString = "You have insufficient funds. You are trying to withdraw a higher amount than available in your balance."
                        }))
                    })
                    .padding([.horizontal], 50)
                    .padding([.vertical], 10)
                    
                    .foregroundColor(Color("DarkColorGradient"))
                    .background(LinearGradient(gradient: Gradient(colors: [Color("Yellow"), Color("LighterYellow")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(25)
                    .offset(x: 0, y: 250)
                }
            }
        }
        .onAppear{
            userInstance.getUserDetailsByAccountNumber(accountNumber: userInstance.currentUser.accountNumber) {
                userDetails in
                userInstance.setCurrentUserDetails(userDetails: userDetails)
                
                //adding this toggle here forces the userInstance ViewModelInstance to update a property
                //by changing this property, we trigger a force redraw of the UI
                //making sure that our values are the most recent
                userInstance.forceReload.toggle()
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
        
    }
}

struct WithdrawView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawView()
    }
}
