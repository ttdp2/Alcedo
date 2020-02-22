//
//  Tweet.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

protocol Tweet {}

struct TextTweet: Tweet, Identifiable {
    var id = UUID()
    var text: String
    var role: Role
}
