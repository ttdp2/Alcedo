//
//  Contact.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

struct Contact: Identifiable, Equatable {
    let id: String
    let name: String
    let avatar: URL?
    var isOnline: Bool
}
