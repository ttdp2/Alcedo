//
//  Message.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

struct Message: Identifiable {
    let id: Int
    let text: String
    let contact: Contact
}
