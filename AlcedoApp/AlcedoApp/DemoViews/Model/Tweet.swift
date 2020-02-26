//
//  Tweet.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

enum Type {
    case text
    case flight
}

struct Tweet: Identifiable {
    let id = UUID()
    let text: String
    let role: Role
    let type: Type
    
    init(text: String, role: Role, type: Type = .text) {
        self.text = text
        self.role = role
        self.type = type
    }
}
