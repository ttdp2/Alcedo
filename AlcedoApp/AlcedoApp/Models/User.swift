//
//  User.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

struct User: Hashable {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
}
