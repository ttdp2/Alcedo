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
            
            let output = self.process(text)
            ws.send(output)
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
    }
    
    private func process(_ text: String) -> String {
        
        guard !isCompleted else {
            isCompleted = false
            return welcome
        }
        
        guard checkOption(text) else {
            return "请回复序列号或回复人工，方可开始服务。"
        }
        
        guard checkIdCard(text) else {
            return "请输入您的身份证号码"
        }
        
        guard checkFlight(text) else {
            return "请输入您的航班号"
        }
        
        guard checkNewDate(text) else {
            return "请输入您要改签的日期"
        }
        
        guard checkNewFlight(text) else {
            return "请输入您要改签的航班号"
        }
        
        return ending()
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
            if text == "id" {
                isIdCardChecked = true
                return true
            }
        }
        return false
    }
    
    private func checkFlight(_ text: String) -> Bool {
        if isFlightChecked {
            return true
        } else {
            if text == "flight" {
                isFlightChecked = true
                return true
            }
        }
        return false
    }
    
    private func checkNewDate(_ text: String) -> Bool {
        if isNewDateChecked {
            return true
        } else {
            if text == "newDate" {
                isNewDateChecked = true
                return true
            }
        }
        return false
    }
    
    private func checkNewFlight(_ text: String) -> Bool {
        if isNewFlightChecked {
            return true
        } else {
            if text == "newFlight" {
                isNewFlightChecked = true
                return true
            }
        }
        return false
    }
    
    private func ending() -> String {
        isCompleted = true
        reset()
        return "End."
    }
    
}
