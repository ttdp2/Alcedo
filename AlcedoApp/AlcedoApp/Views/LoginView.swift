//
//  LoginView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var store: AppStore2
    
    @State private var email = ""
    @State private var showContacts = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 26) {
            Text("Log in")
                .modifier(TitleText())
            
            ErrorTextField(
                title: "Email",
                placeholder: "mail@example.com",
                iconName: "email",
                text: $email,
                isValid: isValid)
            
            Spacer().onTapGesture {
                self.endEditing()
            }
            
            Button(action: login) {
                PrimaryButton(title: "Log In")
            }
            
            NavigationLink(destination: ContactsView(), isActive: $showContacts) {
                EmptyView()
            }
        }
        .padding()
        .onTapGesture {
            self.endEditing()
        }
    }
    
    private func isValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    private func login() {
        showContacts = true
        store.setCurrentUser(Contact(id: "me", name: "Me", avatar: nil, isOnline: true))
    }
    
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
        .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
    
}
