//
//  Tweet.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

protocol Tweetable {
    var id: UUID { get }
    var role: Role { get }
}

struct TextTweet: Identifiable, Tweetable {
    let id = UUID()
    let text: String
    let role: Role
}
