//
//  DataSource.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

struct DataSource {
    
    static let firstUser = User(name: "Robot", avatar: "robot")
    static var secondUser = User(name: "Big Bang", avatar: "", isCurrentUser: true)
    
    static let messages = [
        Message2(content: "Hi, I really love your templates and I would like to buy the chat template", user: DataSource.firstUser),
        Message2(content: "Thanks, nice to hear that, can I have your email please?", user: DataSource.secondUser),
        Message2(content: "😇", user: DataSource.firstUser),
        Message2(content: "Oh actually, I have just purchased the chat template, so please check your email, you might see my order", user: DataSource.firstUser),
        Message2(content: "Great, wait me a sec, let me check", user: DataSource.secondUser),
        Message2(content: "Sure", user: DataSource.firstUser)
    ]
    
}
