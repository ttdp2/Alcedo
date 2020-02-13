//
//  UserController.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

struct UserController {
    
    func index(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.create(on: req.db).map { user }
    }
}
