//
//  DepositView.swift
//  ATM
//
//  Created by Swift Developer on 25.08.22.
//

import SwiftUI

struct DepositView: View {
    @EnvironmentObject var userInstance:UserViewModel
    @State var depositAmount:Double = 0
    @State var showBalance:Double = 0
    @State var showDepositAlert:Bool = false
    @State var depositAlertTitle:String = "ERROR\n"
    @State var depositAlertString:String = "The deposit amount cannot be empty or negative.\n"
    @State var depositAlertButtonText:String = "TRY AGAIN"
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
                    Text("Amount to deposit")
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .offset(x: 0, y: 105)
                    
                    TextField("Amount to deposit", value: $depositAmount, format:.number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 20)
                        .offset(x: 0, y: 95)
                        .keyboardType(.decimalPad)
                    
                    Spacer()
                    
                    Button{
                        if(depositAmount > 0) {
                            CreditCardViewModel().depositToAccountBalance(accountNumber: userInstance.currentUser.accountNumber, depositAmount: depositAmount){ currentBalance in
                                //instantly updates the current balance to match the balance after deposit
                                showBalance = currentBalance
                                //logs this transaction in the database
                                TransactionsViewModel().logDeposit(userId: userInstance.currentUser.id, depositAmount: depositAmount)
                            }
                        } else {
                            showDepositAlert = true
                        }
                    } label: {
                        Text("Deposit")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .alert(isPresented: $showDepositAlert, content: {
                        return Alert(title: Text(depositAlertTitle), message: Text(depositAlertString), dismissButton: .default(Text(depositAlertButtonText),                                action: {
                            //---RESETS ERROR MESSAGE WHEN "TRY AGAIN"---//
                            self.depositAlertString = "The deposit amount cannot be empty or negative.\n"
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
        .onTapGesture {//this will allow to unfocus from the text field, which closes the on screen keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
        
    }
}

struct DepositView_Previews: PreviewProvider {
    static var previews: some View {
        DepositView()
    }
}
