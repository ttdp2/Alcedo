//
//  CreateCategory.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Fluent

struct CreateCategory: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.categories)
            .field("id", .int, .identifier(auto: true))
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.categories).delete()
    }
    
}
