//
//  FlightTweet.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/27.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

struct FlightTweet: Identifiable, Tweetable {
    let id = UUID()
    let depCity: String
    let arrCity: String
    let depTime: String
    let arrTime: String
    let flightDate: String
    let flightNo: String
    let role: Role
    
    init(flight: Flight, role: Role) {
        self.depCity = flight.depCity
        self.arrCity = flight.arrCity
        self.depTime = flight.depTime
        self.arrTime = flight.arrTime
        self.flightDate = flight.flightDate
        self.flightNo = flight.flightNo
        self.role = role
    }
}

struct Flight: Codable {
    let depCity: String
    let arrCity: String
    let depTime: String
    let arrTime: String
    let flightDate: String
    let flightNo: String
}
