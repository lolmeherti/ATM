//
//  TransferView.swift
//  ATM
//
//  Created by Swift Developer on 06.09.22.
//

import SwiftUI

struct TransferView: View {
    @EnvironmentObject var userInstance:UserViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Charcoal"), Color("DarkColorGradient")]), startPoint: .top, endPoint: .leading)
                .edgesIgnoringSafeArea(.vertical)
            
            ScrollView{
                
            }
        }
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
