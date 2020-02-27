//
//  TweetStore.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

class TweetStore: ObservableObject, WebSocketDelegate {
    
    @Published var tweets: [Tweetable] = [TextTweet(text: "This is a text tweet", role: me, type: .text),
                                          TextTweet(text: "This is a flight tweet", role: bot, type: .flight),
                                          DateTweet(role: bot)]
    /*
    [Tweet(text: "In to am attended desirous raptures declared diverted confined at.", role: bot),
    Tweet(text: "Collected instantly remaining up certainly to necessary as.", role: bot),
    Tweet(text: "Is handsome an declared at received in extended vicinity subjects.", role: me),
    Tweet(text: "Into miss on he over been late pain an. Only week bore boy what fat case left use.", role: bot),
    Tweet(text: "Your me past an much.", role: bot),
    Tweet(text: "Match round scale now sex style far times.", role: me),
    Tweet(text: "This is a tweet", role: me)]
    */
    
    var webSocket: WebSocket!

    func connect(_ url: URL) {
        print("TweetStore connect to \(url)")
        webSocket = WebSocket(url: url)
        webSocket.delegate = self
    }
    
    func close() {
        webSocket.send(data: "I AM QUIT.".data(using: .utf8)!)
        webSocket.close()
        tweets.removeAll()
    }
    
    func send(_ text: String) {
        let tweet = TextTweet(text: text, role: me)
        tweets.append(tweet)
        
        webSocket.send(text: text)
    }
    
    func webSocket(ws: WebSocket, didReceive text: String) {
        DispatchQueue.main.async {
            let tweet = TextTweet(text: text, role: bot)
            self.tweets.append(tweet)
        }
    }
    
    func webSocket(ws: WebSocket, didReceive data: Data) {
        guard let flights = try? JSONDecoder().decode([Flight].self, from: data) else {
            print("Decode [Flight].self Error")
            return
        }
        
        let flightTweets = flights.map { FlightTweet(flight: $0, role: bot) }
        
        DispatchQueue.main.async {
            self.tweets += flightTweets
        }
    }
    
}
