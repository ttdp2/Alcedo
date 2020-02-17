//
//  ContentView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var content: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(content)
        .padding(10)
            .foregroundColor(isCurrentUser ? .white : .black)
            .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(content: "Welcome to Alcedo", isCurrentUser: false)
    }
}
