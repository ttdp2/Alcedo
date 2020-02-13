//
//  CreateUser.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Fluent

struct CreateUser: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.users)
            .field("id", .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("team_id", .int, .references(Schema.teams, "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.users).delete()
    }
    
}
