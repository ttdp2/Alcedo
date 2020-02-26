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
    @ObservedObject private var store = TweetStore()
    
    let service: ServiceEnum
    
    init(service: ServiceEnum) {
        self.service = service
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
                        self.buildView(at: i)
                            .listRowInsets(EdgeInsets(
                                top: i == 0 ? 16 : 0,
                                leading: 12,
                                bottom: self.isLastTweet(at: i) ? 20 : 6,
                                trailing: 12))
                            .onTapGesture {
                                print(index)
                        }
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
        .navigationBarTitle(service.isTicket ? Text("机票服务") : Text("会员服务"), displayMode: .inline)
        .onAppear(perform: startTweets)
        .onDisappear(perform: closeTweets)
    }
    
    private func buildView(at index: Int) -> AnyView {
        let tweet = store.tweets[index]
        let isIncoming = tweet.role != me
        let isLast = isLastTweet(at: index)
        
        switch tweet.type {
        case .text:
            return AnyView(TextRow(tweet: tweet, isIncoming: isIncoming, isLast: isLast))
        case .flight:
            return AnyView(FlightRow(tweet: tweet, isIncoming: isIncoming, isLast: isLast))
        }

    }
    
    private func startTweets() {
        switch service {
        case .ticket(let url):
            store.connect(url)
        case .member(let url):
            store.connect(url)
        }
    }
    
    private func closeTweets() {
        store.close()
    }
    
    private func isLastTweet(at index: Int) -> Bool {
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
        ChatingView(service: .member(URL(string: "ws://example.com")!))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
    
}
