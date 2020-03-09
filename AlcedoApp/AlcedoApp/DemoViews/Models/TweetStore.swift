//
//  TweetStore.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

class TweetStore: ObservableObject, WebSocketDelegate {
    
    @Published var tweets: [Tweetable] = [
//        FlightTweet(flight: Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-01", flightNo: "MU5515"), role: bot),
//        FlightTweet(flight: Flight(depCity: "青岛流亭", arrCity: "上海虹桥", depTime: "14:50", arrTime: "16:40", flightDate: "2020-03-05", flightNo: "MU5520"), role: bot),
//        TextTweet(text: "Haha", role: bot)
    ]

    private var webSocket: WebSocket!
    private var serverRole: Role = bot

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
        
        if text == "人工" {
            serverRole = male
        } else if text == "Bot" {
            serverRole = bot
        }
        
        webSocket.send(text: text)
    }
    
    func webSocket(ws: WebSocket, didReceive text: String) {
        DispatchQueue.main.async {
            let tweet: Tweetable
            if text == "DatePicker" {
                tweet = DateTweet(text: "请选择您要改签的日期", role: self.serverRole)
            } else {
                tweet = TextTweet(text: text, role: self.serverRole)
            }
            self.tweets.append(tweet)
        }
    }
    
    func webSocket(ws: WebSocket, didReceive data: Data) {
        if let flight = try? JSONDecoder().decode(Flight.self, from: data) {
           let tweet = FlightTweet(flight: flight, role: self.serverRole)
            
            DispatchQueue.main.async {
                self.tweets.append(tweet)
            }
        } else {
            
            guard let flights = try? JSONDecoder().decode([Flight].self, from: data) else {
                print("Decode [Flight].self Error")
                return
            }
            
            let flightTweets = flights.map { FlightTweet(flight: $0, role: self.serverRole) }
            
            DispatchQueue.main.async {
                self.tweets += flightTweets
            }
        }
    }
    
}
