//
//  TransferView.swift
//  ATM
//
//  Created by Swift Developer on 06.09.22.
//

import SwiftUI

struct TransferView: View {
    @EnvironmentObject var userInstance:UserViewModel //USER FROM ENVIRONMENT
    //---FORM VARIABLES---//
    @State var recipientAccountNumber:String = ""
    @State var recipientFirstName:String = ""
    @State var recipientLastName:String = ""
    @State var recipientTransferSubject:String = ""
    @State var recipientTransferAmount:Double = 0
    //---FORM VARIABLES---//
    
    //---ERROR VARIABLES SECTION---//
    @State var isValidFirstName:Bool = false
    @State var isValidLastName:Bool = false
    @State var isValidAccountNumber:Bool = false
    @State var isValidTransferSubject:Bool = false
    @State var isValidTransferAmount:Bool = false
    @State var isTransferSuccessful:Bool = false
    //---ERROR VARIABLES SECTION END---//
    
    //---ALERT TEXT CONFIG---//
    @State var showTransferAlert:Bool = false
    @State var transferAlertTitle:String = "Error"
    @State var transferAlertString:String = "The following field(s) are empty or incorrect:\n"
    @State var transferAlertButtonText:String = "TRY AGAIN"
    //---ALERT TEXT CONFIG---//
    
    
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
                    
                    isValidAccountNumber = CreditCardValidator().validateAccountNumber(recipientAccountNumber)
                    
                    //if the account number is in valid format
                    //we check the database to see if it is registered
                    if(isValidAccountNumber) {
                        CreditCardViewModel().isAccountNumberRegistered(accountNumber: recipientAccountNumber) { accountNumberFound in
                            if(!accountNumberFound){
                                //if no account number has been found
                                //then it is not a valid account number
                                
                                setUnregisteredRecipientAlert()
                                showTransferAlert = true
                                
                            } else {//if we find the account numbere is registered
                                
                                //we are reloading the user details to make sure
                                //that we are up to date with any transactions
                                //before we allow a transfer of balance
                                userInstance.forceReload.toggle()
                                
                                //---VALIDATING FORM INPUT SECTION---//
                                isValidFirstName = UserInputValidator().userNameValidator(name: recipientFirstName)
                                
                                isValidLastName = UserInputValidator().userNameValidator(name: recipientLastName)
                                
                                //cant transfer 0 or more than is available in our balance
                                if(recipientTransferAmount > 0 && recipientTransferAmount <= userInstance.currentUser.balance) {
                                    isValidTransferAmount = true
                                }
                                
                                isValidTransferSubject = recipientTransferSubject.count > 4 //TODO: transfer the hardcoded data to a config file
                                //---VALIDATING FORM INPUT SECTION END---//
                                
                                //---CHECKING VALIDATION RESULTS SECTION---//
                                if(isValidFirstName &&
                                   isValidLastName &&
                                   isValidTransferAmount &&
                                   isValidTransferSubject){
                                    
                                    
                                    //---TRANSFER EXECUTES HERE---//
                                    TransactionsViewModel().transferBalance(senderAccountNumber: userInstance.currentUser.accountNumber,
                                                                            recipientAccountNumber: recipientAccountNumber,
                                                                            transferAmount: recipientTransferAmount) { transferSuccessful in
                                        
                                        if(transferSuccessful){
                                            //---LOGGING TRANSACTION SECTION---//
                                            TransactionsViewModel().logTransfer(
                                                userId: userInstance.currentUser.id,
                                                recipientFirstName: recipientFirstName,
                                                recipientLastName: recipientLastName,
                                                transferSubject: recipientTransferSubject,
                                                transferAmount: recipientTransferAmount)
                                            //---LOGGING TRANSACTION SECTION END---//
                                            
                                            //we are setting the success message here
                                            setSuccessAlert(transferAmount: recipientTransferAmount)
                                            //finally we let the user that the transfer was done successfully
                                            //by an alert pop-up
                                            showTransferAlert = true
                                        }
                                    }
                                } else {
                                    //---COMPILING THE ERROR MESSAGE FOR THE ALERT---//
                                    if(!isValidFirstName){
                                        self.transferAlertString = transferAlertString + "First Name\n"
                                    }
                                    
                                    if(!isValidLastName){
                                        self.transferAlertString = transferAlertString + "Last Name\n"
                                    }
                                    
                                    if(!isValidTransferSubject){
                                        self.transferAlertString = transferAlertString + "Transfer Subject\n"
                                    }
                                    
                                    if(!isValidTransferAmount){
                                        self.transferAlertString = transferAlertString + "Transfer Amount is empty or exceeds the current balance\n"
                                    }
                                    
                                    //---ENABLING THE ALERT POP-UP---//
                                    showTransferAlert = true
                                }
                            }
                        }
                    }
                } label: {
                    Text("Transfer")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                //---ALERT POP-UP---//
                .alert(isPresented: $showTransferAlert, content: {
                    return getValidationErrors()
                })
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
    
    //---ALERT FUNCTIONS---//
    func getValidationErrors() -> Alert{
        return Alert(title: Text(transferAlertTitle), message: Text(transferAlertString), dismissButton: .default(Text(transferAlertButtonText), action: {
            //---RESETS ERROR MESSAGE WHEN "TRY AGAIN"---//
            self.transferAlertString = "The following field(s) are empty or incorrect:\n"
        }))
    }
    
    func setSuccessAlert(transferAmount:Double) {
        self.transferAlertTitle = "TRANSFER SUCCESSFUL!"
        self.transferAlertString = """
                                
                                You have transferred $\(transferAmount) successfully!
                                
                                """
        self.transferAlertButtonText = "CONTINUE"
    }
    
    func setUnregisteredRecipientAlert() {
        self.transferAlertTitle = "ERROR"
        self.transferAlertString = """
                                This account number is incorrect!
                                """
        self.transferAlertButtonText = "TRY AGAIN"
    }
    
}



struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
