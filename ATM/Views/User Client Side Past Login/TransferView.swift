//
//  TransferView.swift
//  ATM
//
//  Created by Swift Developer on 06.09.22.
//

import SwiftUI

struct TransferView: View {
    @EnvironmentObject var userInstance:UserViewModel
    @State var recipientAccountNumber:String = ""
    @State var recipientFirstName:String = ""
    @State var recipientLastName:String = ""
    @State var recipientTransferSubject:String = ""
    @State var recipientTransferAmount:Double = 0
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .leading)
                .edgesIgnoringSafeArea(.vertical)
            ScrollView{
                Group{
                    VStack{
                        
                        Text("Recipient Information")
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("LighterYellow"))
                            .padding([.top,.bottom], 40)
                        
                        HStack{
                            
                            VStack{
                                Text("First Name")
                                TextField("First Name", text: $recipientFirstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 20)
                            }
                            
                            VStack{
                                Text("Last Name")
                                TextField("Last Name", text: $recipientLastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 20)
                            }
                            
                        }
                        
                        Text("Account Number")
                        
                        TextField("xxxx-xxxx-xxxx-xxxx", text: $recipientAccountNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 20)
                        
                        Text("Transfer Subject")
                        TextField("Subject", text: $recipientTransferSubject)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 20)
                        
                        Text("Transfer Amount")
                        TextField("Transfer Amount", value: $recipientTransferAmount, format:.number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 20)
                    }
                }
                
                Button {
                    
                    //---TODO: VALIDATION---//
                    
                    //---LOGGING TRANSACTION---//
                    TransactionsViewModel().logTransfer(
                        userId: userInstance.currentUser.id,
                        recipientFirstName: recipientFirstName,
                        recipientLastName: recipientLastName,
                        transferSubject: recipientTransferSubject,
                        transferAmount: recipientTransferAmount)
                    
                    //--TODO: SUBTRACTING TRANSACTION AMOUNT FROM BALANCE--//
                    
                    //--TODO: DEPOSIT TRANSACTION AMOUNT TO THE RECIPIENT--//
                    
                    //--TODO: CHECK IF RECIPIENT EXISTS, SHOW ALERTS ON SUCCESS/FAILURE--//
                } label: {
                    Text("Transfer")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding([.horizontal], 50)
                .padding([.vertical], 10)
                
                .foregroundColor(Color("DarkColorGradient"))
                .background(LinearGradient(gradient: Gradient(colors: [Color("Yellow"), Color("LighterYellow")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(25)
                .offset(y: 35)
            }
        }
        .onTapGesture {//this will allow to unfocus from the text field, which closes the on screen keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
