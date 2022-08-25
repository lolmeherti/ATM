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
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                            .foregroundColor(.white)
                        Text("2591-5311-2321-9961")
                            .foregroundColor(Color("DarkColorGradient"))
                            .font(.system(size:20, weight: .bold, design: .rounded))
                        
                    }
                    .offset(x: 0, y: -20)
                    
                    HStack(){
                        Text("Valid:")
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                        Text("12/23")
                            .foregroundColor(Color("DarkColorGradient"))
                        Spacer()
                        Text("CVC:")
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                           Text("525")
                            .foregroundColor(Color("DarkColorGradient"))
                    }
                    .offset(x: 0, y: -25)
                    .frame(width: 269)
                    
                    
                    HStack{
                        Text("FirstName")
                        Text("LastName")
                    }
                    .font(.system(size:22, weight: .bold, design: .rounded))
                    .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                    .foregroundColor(.white)
                    .offset(y: -10)
                    
                    
                    HStack{
                        Text("Balance:")
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
                        Text("2.501.91")
                            .foregroundColor(Color("DarkColorGradient"))
                            .font(.system(size:20, weight: .bold, design: .rounded))
                    }
                    .offset(x: 70, y: 20)
                    
                    
                }
                .font(.system(size:16, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            }
            .offset(x: 0, y: -220)
            .padding()
            
        }
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}
