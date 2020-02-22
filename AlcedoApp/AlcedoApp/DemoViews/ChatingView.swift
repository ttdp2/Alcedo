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
    
    @State var tweets = [TextTweet(text: "In to am attended desirous raptures declared diverted confined at.", role: bot),
                         TextTweet(text: "Collected instantly remaining up certainly to necessary as.", role: bot),
                         TextTweet(text: "Is handsome an declared at received in extended vicinity subjects.", role: me),
                         TextTweet(text: "Into miss on he over been late pain an. Only week bore boy what fat case left use.", role: bot),
                         TextTweet(text: "Your me past an much.", role: bot),
                         TextTweet(text: "Match round scale now sex style far times.", role: me),
                         TextTweet(text: "This is a tweet", role: me)]
    
    let webSocket = WebSocket(url: URL(string: "ws://127.0.0.1:8080/bot")!)
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        //        webSocket.delegate = self
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
                    ForEach(0..<tweets.count, id: \.self) { i in
                        TweetRow(tweet: self.tweets[i], isIncoming: self.tweets[i].role != me,
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
        let tweet = tweets[index]
        let next = index < tweets.count - 1 ? tweets[index + 1] : nil
        return tweet.role != next?.role
    }
    
    private func sendTapped(text: String) {
        webSocket.send(text: text)
        endEditing()
    }
    
}

extension ChatingView: WebSocketDelegate {
    
    func webSocket(ws: WebSocket, didReceive text: String) {
        print(text)
        tweets.append(TextTweet(text: text, role: bot))
    }
    
    func webSocket(ws: WebSocket, didReceive data: Data) {}
    
}

struct Chating_Previews: PreviewProvider {
    
    static var previews: some View {
        ChatingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
    
}
