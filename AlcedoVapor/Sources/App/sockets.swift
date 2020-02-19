//
//  sockets.swift
//  App
//
//  Created by Tian Tong on 2020/2/19.
//

import Vapor

func sockets(_ app: Application) throws {
    app.webSocket("alcedo") { (request, socket) in
        socket.onText { (ws, text) in
            print(text)
        }
    }
}
