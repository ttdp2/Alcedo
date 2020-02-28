//
//  DateTweet.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/28.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct DateTweet: Identifiable, Tweetable {
    let id = UUID()
    let text: String
    let role: Role
}
