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
    
    let ticketController = TicketController()
    app.webSocket("ticket", onUpgrade: ticketController.ticket)
    
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
    
    app.webSocket("flight") { req, ws in
        let flights = [
            Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-02-25", flightNo: "MU5515"),
            Flight(depCity: "青岛流亭", arrCity: "上海虹桥", depTime: "14:50", arrTime: "16:40", flightDate: "2020-02-28", flightNo: "MU5520")
            ]
        
        guard let data = try? JSONEncoder().encode(flights) else {
            return
        }
        
        ws.send(raw: data, opcode: .binary)
    }
}
