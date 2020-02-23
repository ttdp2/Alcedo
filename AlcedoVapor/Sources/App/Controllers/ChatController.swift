//
//  ChatController.swift
//  App
//
//  Created by Tian Tong on 2020/2/20.
//

import Vapor

struct ChatController {
    
    let chatRobot = ChatRobot()
    
    func channelA(req: Request, ws: WebSocket) -> () {
        ws.onText { _, text in
            self.chatRobot.chatWithA(ws)
        }
    }
    
    func channelB(req: Request, ws: WebSocket) -> () {
        ws.onText { _, text in
            self.chatRobot.chatWithB(ws)
        }
    }
    
    func channelC(req: Request, ws: WebSocket) -> () {
        ws.onText { _, text in
            ws.send(readLine() ?? "Empty")
        }
    }
    
}

class ChatRobot {
    
    let messagesA = [
        "Hi, welcome to channel A.",
        "Nice to meet you!",
        "Bye Bye!"
    ]
    
    let messagesB = [
        "Hi, welcome to channel B.",
        "How are you?",
        "Cool"
    ]
    
    var counterA = 0
    var counterB = 0
    
    func chatWithA(_ ws: WebSocket) {
        let index = counterA % 3
        let message = messagesA[index]
        ws.send(message)
        
        counterA += 1
    }
    
    func chatWithB(_ ws: WebSocket) {
        let index = counterB % 3
        let message = messagesB[index]
        ws.send(message)
        
        counterB += 1
    }
    
}
