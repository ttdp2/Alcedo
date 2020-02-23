//
//  TweetStore.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

class TweetStore: ObservableObject, WebSocketDelegate {
    
    @Published var tweets: [TextTweet] = []
    /*
    [TextTweet(text: "In to am attended desirous raptures declared diverted confined at.", role: bot),
    TextTweet(text: "Collected instantly remaining up certainly to necessary as.", role: bot),
    TextTweet(text: "Is handsome an declared at received in extended vicinity subjects.", role: me),
    TextTweet(text: "Into miss on he over been late pain an. Only week bore boy what fat case left use.", role: bot),
    TextTweet(text: "Your me past an much.", role: bot),
    TextTweet(text: "Match round scale now sex style far times.", role: me),
    TextTweet(text: "This is a tweet", role: me)]
    */
    
    var webSocket: WebSocket!
    
    init() {
        print("TweetStore init")
        webSocket = WebSocket(url: URL(string: "ws://127.0.0.1:8080/bot")!)
        webSocket.delegate = self
    }
    
    func send(_ text: String) {
        let tweet = TextTweet(text: text, role: me)
        tweets.append(tweet)
        
        webSocket.send(text: text)
    }
    
    func webSocket(ws: WebSocket, didReceive text: String) {
        DispatchQueue.main.async {
            let tweet = TextTweet(text: text, role: service2)
            self.tweets.append(tweet)
        }
    }
    
    func webSocket(ws: WebSocket, didReceive data: Data) {
        // No content
    }
    
}