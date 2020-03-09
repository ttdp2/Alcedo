//
//  FlightChangeController.swift
//  App
//
//  Created by Tian Tong on 3/9/20.
//

import Vapor

class FlightChangeController {
    
    let welcome =
    """
        欢迎进入机票服务，以下业务可提供自助办理：

        1. 机票改签
        2. 机票验真
        3. 机票行程单寄送

        回复对应序列号即可办理，如需人工服务，请回复人工。
        """
    
    let bookedFlights = [
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-11", flightNo: "MU5515"),
        Flight(depCity: "青岛流亭", arrCity: "上海虹桥", depTime: "14:50", arrTime: "16:40", flightDate: "2020-03-15", flightNo: "MU5520")
    ]
    let bookedMessgae = "经查询您有以上未出行航班，请选择需要改签的，或回复航班号"
    
    var availableFlights = [
        Flight(depCity: "上海虹桥", arrCity: "北京首都", depTime: "09:00", arrTime: "11:20", flightDate: "2020-03-10", flightNo: "MU5103"),
        Flight(depCity: "上海虹桥", arrCity: "北京首都", depTime: "13:00", arrTime: "15:20", flightDate: "2020-03-10", flightNo: "MU5111"),
        Flight(depCity: "上海虹桥", arrCity: "北京首都", depTime: "15:00", arrTime: "17:15", flightDate: "2020-03-10", flightNo: "MU5115")
    ]
    let availableMessage = "经查询有以上航班可供改签，请选择，或回复航班号"
    
    private var isOptionChecked = true
    private var isIdCardChecked = true
    private var isFlightChecked = true
    private var isNewDateChecked = false
    private var isNewFlightChecked = false
    private var isCompleted = false
    
    private var isManualModel = false
    
    func handleFlightChange(req: Request, ws: WebSocket) {
        let userInfo =
              """
              旅客信息：
              姓名：胡歌  票号：781-123456789
              航班号：MU5111   联系方式：13912345678
              起飞：上海虹桥   到达：北京首都
              """
              ws.send(userInfo)
              
              let chatHistory =
              """
              IVR意图：不正常航班改期
              IVR聊天记录：
              ---------------------------------------
              AI：您好，我是小东，有什么能帮您的？
              旅客：我的航班延误了，我要改期
              AI：已识别您为不正常航班改期，你可以在在线客服自助办理机票改期。
              """
        
              ws.send(chatHistory)
        
        ws.send("请问您想改期到什么时间？")
        
        ws.onText { _, text in
            print("USER INPUT: \(text)")
            
            if self.isManualModel {
                if text == "Bot" {
                    self.isManualModel = false
                    self.reset()
                    ws.send(self.welcome)
                    return
                }
                
                guard let text = readLine() else {
                    return
                }
                
                ws.send(text)
            } else {
                if text == "人工" {
                    self.isManualModel = true
                    ws.send("很高兴为您服务，请问有什么可以帮助您的？")
                    return
                }
                
                self.process(text, webSocket: ws)
            }
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
        isOptionChecked = true
        isIdCardChecked = true
        isFlightChecked = true
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
        
        guard checkFlightConfirmed(text) else {
            guard let data = try? JSONEncoder().encode(availableFlights.last) else {
                return
            }
            
            ws.send(raw: data, opcode: .binary)
            ws.send("请确认您要改期到的航班信息")
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
        
        return true
    }
    
    private func checkIdCard(_ text: String) -> Bool {
        if isIdCardChecked {
            return true
        } else {
            if text.count == 18 && text.isNumber {
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
            if text.contains("明天") {
                newDate = "2020-03-10"
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
            if text == "MU5103" || text == "MU5111" || text == "MU5115" {
                newFlight = text
                isNewFlightChecked = true
                return true
            }
        }
        return false
    }
    
    var isFlightConfirmed = false
    private func checkFlightConfirmed(_ text: String) -> Bool {
        if isFlightConfirmed {
            return true
        } else {
            if text == "确认" {
                isFlightConfirmed = true
                return true
            }
        }
        
        return false
    }
    
}

