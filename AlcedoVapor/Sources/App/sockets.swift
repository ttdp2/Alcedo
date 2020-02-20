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
}
