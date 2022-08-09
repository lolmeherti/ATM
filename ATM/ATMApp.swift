//
//  ATMApp.swift
//  ATM
//
//  Created by Swift Developer on 20.07.22.
//

import SwiftUI
import Firebase

@main
struct ATMApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            UserLoginView()
        }
    }
}
