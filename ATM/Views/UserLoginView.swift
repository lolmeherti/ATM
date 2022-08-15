//
//  UserLoginView.swift
//  ATM
//
//  Created by Swift Developer on 20.07.22.
//

import SwiftUI

struct UserLoginView: View {
    
    @State var accountNumber: String = ""
    @State var pinNumber: String = ""
    
    var body: some View {
        NavigationView{
            //addressing the ZStack in order to integrate a gradient background color
            ZStack{
                
                //defining the gradient type and colors for the ZStack
                LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.vertical)
                
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
                        
                        Text("5-Digit Pin")
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        TextField("xxxxx", text: $pinNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal, 8)
                        
                        Spacer()
                        
                        Spacer()
                        
                        HStack{
                            
                            //button to request user login with credentials
                            Button {
                                let userViewModelInstance = UserViewModel()
                                let userLoggedIn = userViewModelInstance.loginUser(
                                    accountNumber: accountNumber,
                                    pinCode: pinNumber)
                                
                                if(userLoggedIn){
                                    //TODO REDIRECT TO A LOGIN VIEW Q_Q
                                }else{
                                    //TODO SHOW AN ALERT IF THE LOGIN FAILED
                                }
                                
                                
                            } label: {
                                Text("Login")
                                    .fontWeight(.semibold)
                                    .font(.title)
                            }
                            
                            .padding([.horizontal], 80)
                            .padding([.vertical], 10)
                            
                            .foregroundColor(Color("Charcoal"))
                            .background(LinearGradient(gradient: Gradient(colors: [Color("Yellow"), Color("LighterYellow")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(25)
                        }
                        .padding(.bottom, 25)
                    }

                    Spacer()
                    
                    NavigationLink(
                        destination: UserSignUpView()){
                            Text("Sign Up") //this sign up text sends the user to the sign up view
                        }
                    }
                    .padding()
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
