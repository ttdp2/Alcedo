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
    
    let flightController = FlightController()
    app.webSocket("flight", onUpgrade: flightController.handleFlight)
    
    app.webSocket("member") { req, ws in
        let welcome =
        """
            欢迎进入会员服务，以下业务可提供自助办理：

            1. 会员积分查询
            2. 会员等级查询
            3. 积分商品兑换

            回复对应序列号即可办理，如需人工服务，请回复人工。
            """
        ws.send(welcome)
        
        ws.onText { _, text in
            print(text)
            let message = readLine()
            ws.send(message ?? "Empty")
        }
    }
    
}
