//
//  FlightController.swift
//  App
//
//  Created by Tian Tong on 2020/2/27.
//

import Vapor

class FlightController {
    
    let bookedFlights = [
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-01", flightNo: "MU5515"),
        Flight(depCity: "青岛流亭", arrCity: "上海虹桥", depTime: "14:50", arrTime: "16:40", flightDate: "2020-03-05", flightNo: "MU5520")
    ]
    
    let availableFlights = [
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-02", flightNo: "MU5515"),
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "18:00", arrTime: "19:35", flightDate: "2020-03-02", flightNo: "MU5517"),
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "21:15", arrTime: "22:55", flightDate: "2020-03-02", flightNo: "MU5519")
    ]
    
    let bookedMessgae = "您未出行的航班信息如上，请选择或回复航班号"
    let dateMessage = "请选择您要出行的日期"
    let searchMessage = "为您查询到可改签的航班如上，请选择或回复航班号"
    let confirmMessage = "已为您改签成功，新航班信息如上，祝您旅途愉快！"
    
    func handleFlight(req: Request, ws: WebSocket) {
        guard let data = try? JSONEncoder().encode(bookedFlights) else {
            return
        }
        
        ws.send(raw: data, opcode: .binary)
        ws.send(bookedMessgae)
        ws.send(dateMessage)
        ws.send(searchMessage)
        ws.send(confirmMessage)
    }
    
}
