//
//  TicketController.swift
//  App
//
//  Created by Tian Tong on 2020/2/23.
//

import Vapor

class TicketController {
    
    let menus = [
        """
        欢迎进入机票服务，以下业务可提供自助办理：

        1. 机票改签
        2. 机票验真
        3. 机票退票
        4. 机票行程单寄送

        回复对应序列号即可办理，如需人工服务，请回复人工。
        """
    ]
    
    func ticket(req: Request, ws: WebSocket) {
        menus.forEach {
            ws.send($0)
        }
        
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
    }
    
    private func process(_ text: String) -> String {
        // Step 1: Check option
        guard checkOption(text) else {
            return "请回复序列号或回复人工，方可开始服务。"
        }
        
        return "Welcome"
    }
    
    private var isOptionChecked = false
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
    
    private var isIdCardChecked = false
    
}
