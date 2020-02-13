//
//  User.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

final class User: Model, Content {
    static let schema = Schema.users
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "email")
    var email: String
    
    @Parent(key: "team_id")
    var team: Team
    
    init() {}
    
    init(id: Int? = nil, name: String, email: String, teamID: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.$team.id = teamID
    }
}
