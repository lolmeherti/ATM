//
//  AccountInfoView.swift
//  ATM
//
//  Created by Swift Developer on 16.08.22.
//

import SwiftUI

struct AccountInfoView: View {
    @EnvironmentObject var userInstance:UserViewModel
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .leading)
                .edgesIgnoringSafeArea(.vertical)
            
            ZStack {
                LinearGradient(colors: [Color("Gold3"), Color("Gold2"), Color("Gold3"), Color("Gold4")],
                               startPoint: .topLeading,
                               endPoint: .bottom)
                .opacity(1)
                .edgesIgnoringSafeArea(.vertical)
                .frame(width: 350, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: Color.black.opacity(0.8), radius: 15, x: 0, y: 10)
                
                VStack(alignment: .center, spacing: 16){
                    
                    HStack(){
                        Text("IBAN:")
                            .bold()
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                            .foregroundColor(.white)
                        Text(self.userInstance.currentUser.accountNumber)
                            .bold()
                            .foregroundColor(Color("DarkColorGradient"))
                        
                    }
                    .offset(x: 0, y: -15)
                    
                    HStack(){
                        Text("Valid:")
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                        Text(self.userInstance.currentUser.card_expiration_date, format: .dateTime.year().month())
                            .bold()
                            .foregroundColor(Color("DarkColorGradient"))
                        Spacer()
                        Text("CVC:")
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                        Text(self.userInstance.currentUser.cvc)
                            .bold()
                            .foregroundColor(Color("DarkColorGradient"))
                    }
                    .offset(x: 0, y: -25)
                    .frame(width: 240)
                    
                    HStack{
                        Text(self.userInstance.currentUser.firstName)
                            .bold()
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                            .foregroundColor(.white)
                            
                        Text(self.userInstance.currentUser.lastName)
                            .bold()
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                            .foregroundColor(.white)
                    }
                    .foregroundColor(Color("DarkColorGradient"))
                    .offset(y: -10)
                    
                    
                    HStack{
                        Text("Balance:")
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                        Text("$\(self.userInstance.currentUser.balance, specifier: "%.2f")")
                            .bold()
                            .foregroundColor(Color("DarkColorGradient"))
                    }
                    .offset(x: 70, y: 15)
                }
                
                .foregroundColor(.white)
                
                RecentTransactionsView()
                    .offset(x: 0, y: 250)
            }
            .offset(x: 0, y: -220)
            .padding()
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
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}
