//
//  Team.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

final class Team: Model, Content {
    static let schema = Schema.teams
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Children(for: \.$team)
    var members: [User]
    
    @Parent(key: "service_id")
    var service: Service
    
    init() {}
    
    init(id: Int? = nil, name: String, serviceID: Int) {
        self.id = id
        self.name = name
        self.$service.id = serviceID
    }
}
