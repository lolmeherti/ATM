//
//  SideMenu.swift
//  ATM
//
//  Created by Swift Developer on 16.08.22.
//

import SwiftUI

struct SideMenu: View {
    
    @Binding var currentTab: String
    
    var body: some View {
        VStack{
            
            HStack(spacing: 15){
                Image(systemName: "shekelsign.square")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .font(.system(size: 75))
                    .foregroundColor(Color("LighterYellow"))
                
                Text("Albatros")
                    .font(.title2.bold())
                    .foregroundColor(Color("LighterYellow"))
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: 25){
                    CustomTabButton(icon: "mail", title: "Account")
                    
                    CustomTabButton(icon: "minus", title: "Withdraw")
                    
                    CustomTabButton(icon: "plus", title: "Deposit")
                    
                    Spacer()
                    
                    CustomTabButton(icon: "rectangle.portrait.and.arrow.right", title: "Logout")
                }
                .padding()
                .padding(.top, 45)
            })
            .frame(width: getRect().width / 2, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("BlackMetal")
        )
    }
    
    @ViewBuilder
    func CustomTabButton(icon:String, title: String) -> some View{
        Button {
            
            if(title == "Logout"){
                print("logout")
            } else {
                withAnimation(.linear(duration: 0.15)) {
                  currentTab = title
                }
            }
        } label: {
            HStack(spacing:12){
                
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: currentTab == title ? 48 : nil, height: 48)
                    .foregroundColor(currentTab == title ? Color("DarkColorGradient") :title == "Logout" ? Color("LighterYellow") : .white)
                    .background(
                        ZStack{
                            if currentTab == title {
                                Color("LighterYellow")
                                    .clipShape(Circle())
                            }
                        }
                    )
                
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor( currentTab == title ? Color("LighterYellow") : .white)
            }
            .padding(.trailing, 14)
            .background(
                ZStack{
                    if currentTab == title {
                        Color("Charcoal")
                            .clipShape(Capsule())
                    }
                }
            )
        }
        .offset(x: currentTab == title ? 15 : 0)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
