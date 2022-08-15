//
//  AccountView.swift
//  ATM
//
//  Created by Swift Developer on 12.08.22.
//

import SwiftUI

struct AccountView: View {
    
    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            
        }
    }
    
    struct AccountView_Previews: PreviewProvider {
        static var previews: some View {
            AccountView()
        }
    }
}
