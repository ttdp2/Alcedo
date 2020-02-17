//
//  LoginView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var error: String?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email, onCommit: validate)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password, onCommit: validate)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: login) {
                    Text("Sign in")
                }.disabled(error != nil)
                
                error.flatMap {
                    Text("Error: \($0)").foregroundColor(.red)
                }
            }.navigationBarTitle("Log in")
        }
    }
    
    func validate() {
        
    }
    
    func login() {
        
    }
    
}
