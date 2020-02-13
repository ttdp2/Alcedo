//
//  CreateService.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Fluent

struct CreateService: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.services)
            .field("id", .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("category_id", .int, .references(Schema.categories, "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.services).delete()
    }
    
}
