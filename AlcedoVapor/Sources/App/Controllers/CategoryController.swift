//
//  CategoryController.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

struct CategoryController {
    
    func index(req: Request) throws -> EventLoopFuture<[Category]> {
        return Category.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<Category> {
        let category = try req.content.decode(Category.self)
        return category.create(on: req.db).map { category }
    }
    
}
