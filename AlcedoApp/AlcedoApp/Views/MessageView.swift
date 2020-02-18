//
//  MessageView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    var message: Message2
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if !message.user.isCurrentUser {
                Image("robot")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            } else {
                Spacer()
            }
            
            ContentView(content: message.content, isCurrentUser: message.user.isCurrentUser)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message2(content: "Welcome to Alcedo, this is an message application. Enjoy it!", user: User(name: "Hello", avatar: "")))
    }
}
