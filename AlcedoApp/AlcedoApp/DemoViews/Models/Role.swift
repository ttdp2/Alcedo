//
//  Role.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

let me = Role(name: "User", icon: "profile0")
let bot = Role(name: "Bot", icon: "role_bot")
let service1 = Role(name: "Service", icon: "role_female")
let service2 = Role(name: "Service", icon: "role_male")

struct Role: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var icon: String
}
