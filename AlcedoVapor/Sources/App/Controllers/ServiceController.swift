//
//  ServiceController.swift
//  App
//
//  Created by Tian Tong on 2020/2/13.
//

import Vapor
import Fluent

struct ServiceController {
    
    func index(req: Request) throws -> EventLoopFuture<[Service]> {
        return Service.query(on: req.db).with(\.$teams).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<Service> {
        let service = try req.content.decode(Service.self)
        return service.create(on: req.db).map { service }
    }
}
