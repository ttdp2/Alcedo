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

        回复对应序列号即可办理，如需人工服务，请回复人工
        """
    ]
    
    func ticket(req: Request, ws: WebSocket) {
        menus.forEach {
            ws.send($0)
        }
        
        ws.onText { _, text in
            print(text)
            
            ws.send(text.reversed())
        }
    }
    
}
