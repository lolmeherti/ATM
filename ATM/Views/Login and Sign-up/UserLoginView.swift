//
//  UserLoginView.swift
//  ATM
//
//  Created by Swift Developer on 20.07.22.
//

import SwiftUI

struct UserLoginView: View {
    
    //---ENVIRONMENT OBJECT FOR USERMODEL---//
    @StateObject var currentUser:UserViewModel = UserViewModel()
    
    //---CREDIT CARD PROPERTIES---//
   
    @State var accountNumber: String = ""
    @State var pinNumber: String = ""
    @State var isUserLoggedIn: Bool = false
    @State var showLoginAlert: Bool = false

    //---CREDIT CARD PROPERTIES---//
    
    
    //---ERROR VARIABLES---//
    @State var showSignUpAlert: Bool = false
    //---ERROR VARIABLES---//
    
    //---ALERT TEXT CONFIG---//
    @State var loginAlertTitle:String = "Error"
    @State var loginAlertString:String = "The following field(s) are empty or incorrect:\n"
    @State var loginAlertButtonText:String = "TRY AGAIN"
    //---ALERT TEXT CONFIG---//
    
    @ViewBuilder//marks view as view builder in order to be able to swap views
    var body: some View {
        if(isUserLoggedIn){
            AccountView()
                .environmentObject(currentUser)
        } else {
            NavigationView{
                //addressing the ZStack in order to integrate a gradient background color
                ZStack{
                    
                    //defining the gradient type and colors for the ZStack
                    LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.vertical)
                    
                    ScrollView{
                        //main VStack to arrange elements vertically underneath each other
                        VStack{
                            
                            VStack{
                                Image(systemName: "shekelsign.square")
                                    .padding(.top, 50)
                                    .padding(.bottom, 50)
                                    .font(.system(size: 75))
                                    .foregroundColor(Color("Yellow"))
                                
                                Text("Account Number")
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                
                                
                                TextField("xxxx-xxxx-xxxx-xxxx", text: $accountNumber)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 20)
                                
                                Text("Pin Code")
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                
                                TextField("xxxx", text: $pinNumber)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 70)
                                Spacer()
                                
                                HStack{
                                    //button to request user login with credentials
                                    Button {
                                        //---LOGIN CREDENTIALS VALIDATION---//
                                        let isValidAccountNumber:Bool = CreditCardValidator().validateAccountNumber(accountNumber)
                                        
                                        let isValidPinCode: Bool = CreditCardValidator().validatePinCode(pinNumber)
                                        //---LOGIN CREDENTIALS VALIDATION---//
                                        
                                        if(isValidAccountNumber && isValidPinCode){//attempt login if input correct
                                            let userViewModelInstance = UserViewModel()
                                            userViewModelInstance.loginUser(
                                                userInputAccountNumber: accountNumber,
                                                userInputPinCode: pinNumber, completion: { validLogin in
                                                    if(validLogin) {//login successful
                                                        
                                                        UserViewModel().getUserDetailsByAccountNumber(accountNumber: accountNumber) { userDetailsOfLoggedInUser in
                                                            
                                                            currentUser.setCurrentUserDetails(userDetails: userDetailsOfLoggedInUser)
                                                            
                                                            currentUser.isUserLoggedIn = true
                                                        }
                                                    } else {//login failed
                                                        self.showLoginAlert = true
                                                        loginAlertString = "\n INCORRECT LOGIN CREDENTIALS"
                                                    }
                                                })
                                        } else {
                                            //ON VALIDATION FAILURE, SHOW WHICH FIELDS FAILED
                                            self.showLoginAlert = true
                                            
                                            if(!isValidAccountNumber) {
                                                loginAlertString = loginAlertString + "Account Number \n"
                                            }
                                            
                                            if(!isValidPinCode) {
                                                loginAlertString = loginAlertString + "5-Digit Pin \n"
                                            }
                                        }
                                    } label: {
                                        Text("Login")
                                            .fontWeight(.semibold)
                                            .font(.title)
                                    }//---ERROR ALERT POP-UP---//
                                    .alert(isPresented: $showLoginAlert, content: {
                                        return getValidationErrors()
                                    })
                                }
                                .padding([.horizontal], 80)
                                .padding([.vertical], 10)
                                
                                .foregroundColor(Color("Charcoal"))
                                .background(LinearGradient(gradient: Gradient(colors: [Color("Yellow"), Color("LighterYellow")]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(25)
                                
                            }
                            Spacer()
                            NavigationLink(
                                destination: UserSignUpView()){
                                    Text("Sign Up")//this sign up text sends the user to the sign up view
                                        .padding(.top, 25)
                                }
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    func getValidationErrors() -> Alert{
        return Alert(title: Text(loginAlertTitle), message: Text(loginAlertString), dismissButton: .default(Text(loginAlertButtonText),                                action: {
            //---RESETS ERROR MESSAGE WHEN "TRY AGAIN"---//
            self.loginAlertString = "The following field(s) are empty or incorrect:\n"
        }))
    }
}

struct UserLoginView_Previews: PreviewProvider {
    static var previews: some View {
        UserLoginView()
    }
}
