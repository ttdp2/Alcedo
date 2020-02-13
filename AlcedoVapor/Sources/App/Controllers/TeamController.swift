//
//  TeamController.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

struct TeamController {
    
    func index(req: Request) throws -> EventLoopFuture<[Team]> {
        return Team.query(on: req.db).with(\.$members).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<Team> {
        let team = try req.content.decode(Team.self)
        return team.create(on: req.db).map { team }
    }
}
