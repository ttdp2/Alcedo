//
//  ErrorTextField.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct ErrorTextField: View {
    
    let title: String
    let placeholder: String
    let iconName: String
    let text: Binding<String>
    let keyboardType: UIKeyboardType
    let isValid: (String) -> Bool
    
    var showsError: Bool {
        if text.wrappedValue.isEmpty {
            return false
        } else {
            return !isValid(text.wrappedValue)
        }
    }
    
    init(title: String,
         placeholder: String,
         iconName: String,
         text: Binding<String>,
         keyboardType: UIKeyboardType = UIKeyboardType.default,
         isValid: @escaping (String) -> Bool = { _ in true }) {
        self.title = title
        self.placeholder = placeholder
        self.iconName = iconName
        self.text = text
        self.keyboardType = keyboardType
        self.isValid = isValid
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(.lightGray))
                .fontWeight(.bold)
            
            HStack {
                TextField(placeholder, text: text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                
                Image(iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(showsError ? .red : Color(red: 189 / 255, green: 204 / 255, blue: 215 / 255))
        }
    }
    
}

struct ErrorTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ErrorTextField(
                title: "Email",
                placeholder: "test@email.com",
                iconName: "email",
                text: .constant(""))
                .padding()
                .previewLayout(.fixed(width: 400, height: 100))
            
            ErrorTextField(
                title: "Email",
                placeholder: "test@email.com",
                iconName: "email",
                text: .constant("some@email.com"))
                .padding()
                .previewLayout(.fixed(width: 400, height: 100))
            
            ErrorTextField(
                title: "Email",
                placeholder: "test@email.com",
                iconName: "email",
                text: .constant("someemail.com"),
                isValid: { _ in false })
                .padding()
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
    
}
