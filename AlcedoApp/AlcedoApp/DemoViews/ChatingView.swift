//
//  ChatingView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct ChatingView: View {
    
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    
    @State var text: String = ""
    
    @ObservedObject private var store = TweetStore()
    
    let role: Role
    
    init(role: Role) {
        print("ChatingView init - \(role.name)")
        self.role = role
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "person") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
            Text("") }
        }
    }
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.top)
            
            VStack {
                List {
                    ForEach(0 ..< store.tweets.count, id: \.self) { i in
                        TweetRow(tweet: self.store.tweets[i], isIncoming: self.store.tweets[i].role != me,
                                 isLastFromContact: self.isMessageLastFromContact(at: i))
                            .listRowInsets(EdgeInsets(
                                top: i == 0 ? 16 : 0,
                                leading: 12,
                                bottom: self.isMessageLastFromContact(at: i) ? 20 : 6,
                                trailing: 12))
                    }
                }
                .onTapGesture {
                    self.endEditing()
                }
                
                ChatTextField(sendAction: sendTapped)
                    .padding(.bottom, keyboardObserver.keyboardHeight)
            }
            .edgesIgnoringSafeArea(keyboardObserver.keyboardHeight == 0.0 ? .leading: .bottom)
            .animation(.easeInOut(duration: 0.3))
        }
        .navigationBarTitle(Text("Bot Service"), displayMode: .inline)
    }
    
    private func isMessageLastFromContact(at index: Int) -> Bool {
        let tweet = store.tweets[index]
        let next = index < store.tweets.count - 1 ? store.tweets[index + 1] : nil
        return tweet.role != next?.role
    }
    
    private func sendTapped(text: String) {
        store.send(text)
        endEditing()
    }
    
}

struct Chating_Previews: PreviewProvider {
    
    static var previews: some View {
        ChatingView(role: me)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
    
}
