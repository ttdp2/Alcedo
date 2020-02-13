//
//  Service.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

final class Service: Model, Content {
    static let schema = Schema.services
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Children(for: \.$service)
    var teams: [Team]
    
    @Parent(key: "category_id")
    var category: Category
    
    init() {}
    
    init(id: Int? = nil, name: String, categoryID: Int) {
        self.id = id
        self.name = name
        self.$category.id = categoryID
    }
}
