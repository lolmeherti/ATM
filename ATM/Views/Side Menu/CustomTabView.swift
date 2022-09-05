//
//  CustomTabView.swift
//  ATM
//
//  Created by Swift Developer on 16.08.22.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var currentTab: String
    
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    withAnimation(.spring()){
                        showMenu = true
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title)
                        .foregroundColor(Color("LighterYellow"))
                }
                .opacity(showMenu ? 0 : 1)
                Spacer()
            }
            .overlay(
                Text(currentTab)
                    .font(.title.bold())
                    .foregroundColor(Color("LighterYellow"))
                    .opacity(showMenu ? 0 : 1)
            )
            .padding([.horizontal, .top])
            .padding(.bottom, 8)
            .padding(.top, getSafeArea().top)
           
            
            TabView(selection: $currentTab) {
                AccountInfoView()//instead of text you can put view
                    .tag("Account")
                
                WithdrawView()
                    .tag("Withdraw")
                
                DepositView()
                    .tag("Deposit")
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            Button {
                withAnimation(.spring()){
                    showMenu = false
                }
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .foregroundColor(Color("LighterYellow"))
            }
            .opacity(showMenu ? 1 : 0)
            .padding()
            .padding(.top)
            ,alignment: .topLeading
        )
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
        )
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
