//
//  ChatView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @State var typingMessage: String = ""
    @EnvironmentObject var chatHelper: ChatHelper
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(chatHelper.realTimeMessages, id: \.self) { msg in
                        MessageView(message: msg)
                    }
                }
                
                HStack {
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                }.frame(minHeight: CGFloat(50)).padding()
            }
        }.navigationBarTitle(Text(DataSource.firstUser.name), displayMode: .inline)
    }
    
    func sendMessage() {
        chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.secondUser))
        typingMessage = ""
    }
    
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView()
        }
    }
}
