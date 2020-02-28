//
//  TicketController.swift
//  App
//
//  Created by Tian Tong on 2020/2/23.
//

import Vapor

class TicketController {
    
    let welcome =
    """
        欢迎进入机票服务，以下业务可提供自助办理：

        1. 机票改签
        2. 机票验真
        3. 机票退票
        4. 机票行程单寄送

        回复对应序列号即可办理，如需人工服务，请回复人工。
        """
    
    let bookedFlights = [
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-01", flightNo: "MU5515"),
        Flight(depCity: "青岛流亭", arrCity: "上海虹桥", depTime: "14:50", arrTime: "16:40", flightDate: "2020-03-05", flightNo: "MU5520")
    ]
    let bookedMessgae = "经查询您有以上未出行航班，请选择需要改签的，或回复航班号"
    
    let availableFlights = [
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-02", flightNo: "MU5515"),
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "18:00", arrTime: "19:35", flightDate: "2020-03-02", flightNo: "MU5517"),
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "21:15", arrTime: "22:55", flightDate: "2020-03-02", flightNo: "MU5519")
    ]
    let availableMessage = "经查询有以上航班可供改签，请选择，或回复航班号"
    
    private var isOptionChecked = false
    private var isIdCardChecked = false
    private var isFlightChecked = false
    private var isNewDateChecked = false
    private var isNewFlightChecked = false
    private var isCompleted = false
    
    func ticket(req: Request, ws: WebSocket) {
        ws.send(welcome)
        
        ws.onText { _, text in
            print("USER INPUT: \(text)")
            
            self.process(text, webSocket: ws)
        }
        
        ws.onBinary { _, byte in
            guard
                let data = byte.getData(at: 0, length: 10),
                let info = String(data: data, encoding: .utf8),
                info == "I AM QUIT."
                else {
                    return
            }
            
            self.reset()
        }
    }
    
    func reset() {
        isOptionChecked = false
        isIdCardChecked = false
        isFlightChecked = false
        isNewDateChecked = false
        isNewFlightChecked = false
        flightNo = ""
        newDate = ""
        newFlight = ""
    }
    
    private func process(_ text: String, webSocket ws: WebSocket) {
        
        guard !isCompleted else {
            isCompleted = false
            ws.send(welcome)
            return
        }
        
        guard checkOption(text) else {
            ws.send("请输入需要办理的业务序列号，或回复人工")
            return
        }
        
        guard checkIdCard(text) else {
            ws.send("请输入您的身份证号码")
            return
        }
        
        guard checkFlight(text) else {
            guard let data = try? JSONEncoder().encode(bookedFlights) else {
                return
            }
            
            ws.send(raw: data, opcode: .binary)
            ws.send(bookedMessgae)
            return
        }
        
        guard checkNewDate(text) else {
            ws.send("DatePicker")
            return
        }
        
        guard checkNewFlight(text) else {
            guard let data = try? JSONEncoder().encode(availableFlights) else {
                return
            }
            
            ws.send(raw: data, opcode: .binary)
            ws.send(availableMessage)
            return
        }
        
        ws.send("""
                已为您改签成功，航班信息:
                \(newDate)
                \(newFlight)
                祝您旅途愉快！
                """)

        isCompleted = true
        reset()
    }
    
    private func checkOption(_ text: String) -> Bool {
        if isOptionChecked {
            return true
        } else {
            if text == "人工" {
                isOptionChecked = true
            } else {
                guard let number = Int(text) else {
                    return false
                }
                
                switch number {
                case 1, 2, 3, 4:
                    isOptionChecked = true
                default:
                    return false
                }
            }
        }
        
        return true
    }
    
    private func checkIdCard(_ text: String) -> Bool {
        if isIdCardChecked {
            return true
        } else {
            if text.count == 3 && text.isNumber {
                isIdCardChecked = true
                return true
            }
        }
        return false
    }
    
    var flightNo = ""
    private func checkFlight(_ text: String) -> Bool {
        if isFlightChecked {
            return true
        } else {
            if text == "MU5515" || text == "MU5520" {
                flightNo = text
                isFlightChecked = true
                return true
            }
        }
        return false
    }
    
    var newDate = ""
    private func checkNewDate(_ text: String) -> Bool {
        if isNewDateChecked {
            return true
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let _ = formatter.date(from: text){
                newDate = text
                isNewDateChecked = true
                return true
            }
        }
        return false
    }
    
    var newFlight = ""
    private func checkNewFlight(_ text: String) -> Bool {
        if isNewFlightChecked {
            return true
        } else {
            if text == "MU5515" || text == "MU5517" || text == "MU5519" {
                newFlight = text
                isNewFlightChecked = true
                return true
            }
        }
        return false
    }
    
}
