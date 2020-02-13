//
//  CreateTeam.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Fluent

struct CreateTeam: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.teams)
            .field("id", .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("service_id", .int, .references(Schema.services, "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.teams).delete()
    }
    
}
