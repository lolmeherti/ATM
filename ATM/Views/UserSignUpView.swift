//
//  UserSignUpView.swift
//  ATM
//
//  Created by Swift Developer on 01.08.22.
//

import SwiftUI

struct UserSignUpView: View {
    @ObservedObject var userViewModel = UserViewModel()
    
    //---USER DETAIL VARIABLES---//
    @State var first_name:String = ""
    @State var last_name:String = ""
    @State var passport_id:String = ""
    @State var email:String = ""
    @State var phone_number:String = ""
    @State var date_of_birth:Date = Date()
    @State var address:String = ""
    @State var city:String = ""
    @State var country:String = ""
    var timestamp:Date = Date.now
    var role:String = "User"//DEFAULT ROLE
    //---USER DETAIL VARIABLES---//
    
    //DATE RANGES FOR DATEPICKER FOR DOF//
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let minAgeDate = calendar.date(byAdding: .year, value: -120, to: .now)
        let maxAgeDate = calendar.date(byAdding: .year, value: -18, to: .now)
        
        return minAgeDate!...maxAgeDate!
    }()
    //DATE RANGES FOR DATEPICKER FOR DOF//
    
    //---ERROR VARIABLES---//
    @State var isValidFirstName:Bool = true
    @State var isValidLastName:Bool = true
    @State var isValidPersonalIdNumber:Bool = true
    @State var isValidAddress:Bool = true
    @State var isValidCity:Bool = true
    @State var isValidCountry:Bool = true
    @State var isValidEmail:Bool = true
    @State var showSignUpAlert:Bool = false
    @State var userDatePickerValueSet = false
    
    //---ALERT TEXT CONFIG---//
    @State var signUpAlertTitle:String = "Error"
    @State var signUpAlertString:String = "The following field(s) are empty or incorrect:\n"
    @State var signUpAlertButtonText:String = "TRY AGAIN"
    //---ALERT TEXT CONFIG---//
    
    //---DATABASE ERROR VARIABLE---//
    @State var signUpSucceeded:Bool = false
    //---DATABASE ERROR VARIABLE---//
    
    //---ERROR VARIABLES---//
    
    
    var body: some View {
        
        ZStack{
            //---CHARCOAL GRADIENT BACKGROUND COLOR---//
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
            //---CHARCOAL GRADIENT BACKGROUND COLOR---//
            ScrollView{
                VStack{
                    Group{
                        HStack{
                            VStack{
                                Text("First Name")
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                
                                TextField("First Name", text: $first_name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 5)
                                    .disableAutocorrection(true)
                            }
                            
                            VStack{
                                Text("Last Name")
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                
                                TextField("Last Name", text: $last_name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 5)
                                    .disableAutocorrection(true)
                            }
                        }
                        
                        Text("Personal Identification Number")
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        TextField("(at least 8 characters)", text: $passport_id)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 5)
                            .disableAutocorrection(true)
                        
                        Text("E-Mail")
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        TextField("example@domain.com", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 5)
                            .disableAutocorrection(true)
                        
                        Text("Phone Number")
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        TextField("Phone Number", text: $phone_number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 5)
                            .disableAutocorrection(true)
                        
                        VStack{
                            DatePicker(
                                "Date of Birth",
                                selection: $date_of_birth,
                                in: dateRange,
                                displayedComponents: [.date])
                            .accentColor(.white)
                            .fixedSize()
                            .padding(20)
                            .foregroundColor(.white)
                            .onChange(of: date_of_birth) { newValue in
                                self.userDatePickerValueSet = true
                            }
                        }
                    }
                    
                    Group{
                        HStack{
                            VStack{
                                Text("Address")
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                
                                TextField("ExampleStreet/1/1/1", text: $address)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 5)
                                    .disableAutocorrection(true)
                            }
                            
                            VStack{
                                Text("City")
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                
                                TextField("Paris", text: $city)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 5)
                                    .disableAutocorrection(true)
                            }
                            
                        }
                        
                        Text("Country")
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        TextField("France", text: $country)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 20)
                            .disableAutocorrection(true)
                    }
                    
                    Spacer()
                    
                    Button {
                        //---SECTION: COLLECTING USER-INPUT TO ARRAY---//
                        let userInput:[String:Any] =
                        [
                            "first_name": first_name,
                            "last_name": last_name,
                            "passport_id": passport_id,
                            "email": email,
                            "phone_number": phone_number,
                            "date_of_birth": date_of_birth,
                            "address": address,
                            "city": city,
                            "country": country,
                            "timestamp": timestamp,
                            "role": role
                        ]
                        //---SECTION: COLLECTING USER-INPUT TO ARRAY---//
                        
                        
                        
                        //-----VALIDATION SECTION-----//
                        self.isValidFirstName = UserInputValidator().userNameValidator(name: first_name)
                        
                        self.isValidLastName = UserInputValidator().userNameValidator(name: last_name)
                        
                        self.isValidPersonalIdNumber =  UserInputValidator().userPassportIdValidator(passport_id: passport_id)
                        
                        self.isValidAddress = UserInputValidator().userAddressValidator(address: address)
                        
                        self.isValidCity = UserInputValidator().userCityValidator(city: city)
                        
                        self.isValidCountry = UserInputValidator().userCountryValidator(country: country)
                        
                        self.isValidEmail = UserInputValidator().userEmailValidator(email: email)
                        //-----VALIDATION SECTION-----//
                        
                        
                        //---CREATES THE NEW USER IF ALL VALIDATIONS PASSED---//
                        if(isValidFirstName &&
                           isValidLastName &&
                           isValidPersonalIdNumber &&
                           isValidAddress &&
                           isValidCity &&
                           isValidCountry &&
                           isValidEmail &&
                           userDatePickerValueSet){
                            
                            
                            //---CHECK IF THE USER IS DUPLICATE---//
                            UserViewModel().isUserDuplicate(userPassportID: passport_id, completion: { foundUserPassportId in
                                if(foundUserPassportId){
                                    //---ENABLES ALERT POP-UP---//
                                    showSignUpAlert = true
                                    
                                    //---SETS NEW ERROR MESSAGE IF THE DATABASE FAILS TO INSERT BECAUSE OF DUPLICATE PASSPORT ID---//
                                    self.signUpAlertTitle = "Registration failed!"
                                    self.signUpAlertString = "Duplicate user detected. If you forgot your login details, please contact our support team!"
                                    self.signUpAlertButtonText = "TRY AGAIN"
                                } else {
                                    //---CREATES A NEW USER AND DELIVERS BACK THE LOGIN DETAILS BECAUSE THEY ARE AUTOMATICALLY GENERATED---//
                                    self.signUpSucceeded = UserViewModel().createNewUser(userDetails:userInput) { creditCardDetails in
                                        let creditCardAccountNumber:String = creditCardDetails["card_account_number"] ?? ""
                                        let creditCardPinCode:String = creditCardDetails["card_pin_code"] ?? ""
                                        //---PASSES THE LOGIN DETAILS TO SET THE SUCCESS ALERT---//
                                        self.setSuccessAlert(accountNumber: creditCardAccountNumber, pinCode: creditCardPinCode)
                                    }
                                    
                                    //---ENABLES ALERT POP-UP---//
                                    showSignUpAlert = true
                                    
                                    //---SETS NEW ALERT MESSAGE IF THE DATABASE THE INSERT SUCCEEDED---//
                                    if(!signUpSucceeded){
                                        self.signUpAlertTitle = "Registration failed!"
                                        self.signUpAlertString = "Please make sure you have a working internet connection or try again later."
                                        self.signUpAlertButtonText = "TRY AGAIN"
                                    }
                                }
                            })
                        } else {
                            //---SECTION: COMPILES THE CUSTOM ERROR MESSAGE---//
                            if(!isValidFirstName){
                                self.signUpAlertString = signUpAlertString + "First Name\n"
                            }
                            
                            if(!isValidLastName){
                                self.signUpAlertString = signUpAlertString + "Last Name\n"
                            }
                            
                            if(!isValidPersonalIdNumber){
                                self.signUpAlertString = signUpAlertString + "ID Number\n"
                            }
                            
                            if(!isValidAddress){
                                self.signUpAlertString = signUpAlertString + "Address\n"
                            }
                            
                            if(!isValidCity){
                                self.signUpAlertString = signUpAlertString + "City\n"
                            }
                            
                            if(!isValidCountry){
                                self.signUpAlertString = signUpAlertString + "Country\n"
                            }
                            
                            if(!isValidEmail){
                                self.signUpAlertString = signUpAlertString + "Email\n"
                            }
                            
                            if(!userDatePickerValueSet){
                                self.signUpAlertString = signUpAlertString + "Date of Birth\n"
                            }
                            //---SECTION: COMPILES THE CUSTOM ERROR MESSAGE---//
                            
                            
                            //---ENABLES ALERT POP-UP---//
                            self.showSignUpAlert = true
                            
                        }
                    } label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    //---ERROR ALERT POP-UP---//
                    .alert(isPresented: $showSignUpAlert, content: {
                        return getValidationErrors()
                    })
                    .padding([.horizontal], 30)
                    .padding([.vertical], 5)
                    //---BUTTON GRADIENT AND COLORS---//
                    .foregroundColor(Color("Charcoal"))
                    .background(LinearGradient(gradient: Gradient(colors: [Color("Yellow"), Color("LighterYellow")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(25)
                }
                .padding()
                .padding(.bottom, 300)
                .padding(.top, 70)
            }
            
        }.ignoresSafeArea()
    }
    
    //---ALERT FUNCTIONS---//
    
    func getValidationErrors() -> Alert{
        return Alert(title: Text(signUpAlertTitle), message: Text(signUpAlertString), dismissButton: .default(Text(signUpAlertButtonText),                                action: {
            //---RESETS ERROR MESSAGE WHEN "TRY AGAIN"---//
            self.signUpAlertString = "The following field(s) are empty or incorrect:\n"
        }))
    }
    
    //this function exists to display the automatically generated account number and pin code after the user signed-up
    //the user doesn't have the option to choose custom account numbers or pin codes
    //this is why the login credentials have to be delivered back to the front end
    func setSuccessAlert(accountNumber:String, pinCode:String) {
        self.signUpAlertTitle = "Registration successful!"
        self.signUpAlertString = """
                                Please manually navigate back to the login page.
                                
                                Your account number is:
                                \(accountNumber)
                                
                                Your pin code is:
                                \(pinCode)
                                """
        self.signUpAlertButtonText = "CONTINUE"
    }
    
    //---ALERT FUNCTIONS---//
}

struct UserSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView()
    }
}
