//
//  Category.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

final class Category: Model, Content {
    static let schema = Schema.categories
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "title")
    var title: String
    
    @Children(for: \.$category)
    var services: [Service]
    
    init() {}
    
    init(id: Int? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
