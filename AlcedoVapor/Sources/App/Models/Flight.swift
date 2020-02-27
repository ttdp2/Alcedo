//
//  Flight.swift
//  App
//
//  Created by Tian Tong on 2020/2/27.
//

import Foundation

struct Flight: Codable {
    let id = UUID()
    let depCity: String
    let arrCity: String
    let depTime: String
    let arrTime: String
    let flightDate: String
    let flightNo: String
}
