//
//  sockets.swift
//  App
//
//  Created by Tian Tong on 2020/2/19.
//

import Vapor

func sockets(_ app: Application) throws {
    let chatController = ChatController()
    app.webSocket("channel", "a", onUpgrade: chatController.channelA)
    app.webSocket("channel", "b", onUpgrade: chatController.channelB)
    app.webSocket("channel", "c", onUpgrade: chatController.channelC)
    
    app.webSocket("bot") { req, ws in
        ws.onText { _, text in
            print(text)
            
            let texts = ["Hi", "How are you?", "Cool"]
            texts.forEach {
                ws.send($0)
            }
        }
    }
    
    app.webSocket("manual") { req, ws in
        ws.onText { _, text in
            print(text)
            
            let message = readLine()
            ws.send(message ?? "Empty")
        }
    }
    
    let flightController = FlightController()
    app.webSocket("flight", onUpgrade: flightController.handleFlight)
}
